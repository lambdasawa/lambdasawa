package main

import (
	"context"
	"log"
	"net/http"
	"time"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	echoAdapter "github.com/awslabs/aws-lambda-go-api-proxy/echo"
	"github.com/labstack/echo/v4"
	lambdadetector "go.opentelemetry.io/contrib/detectors/aws/lambda"
	"go.opentelemetry.io/contrib/instrumentation/github.com/aws/aws-lambda-go/otellambda"
	"go.opentelemetry.io/contrib/instrumentation/github.com/aws/aws-lambda-go/otellambda/xrayconfig"
	"go.opentelemetry.io/contrib/instrumentation/github.com/labstack/echo/otelecho"
	"go.opentelemetry.io/contrib/propagators/aws/xray"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
	"go.opentelemetry.io/otel/propagation"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	"go.opentelemetry.io/otel/trace"
)

var projectName = "golang-opentelemetry-lambda-apigateway-xray"

var tracer trace.Tracer

func main() {
	ctx := context.Background()

	tracerProvider, propagator, cleanup, err := initTracerProvider(ctx)
	if err != nil {
		panic(err)
	}

	defer cleanup(ctx)

	server := createEchoServer(tracerProvider, propagator)

	startLambda(server, tracerProvider)
}

type cleanup = func(ctx context.Context)

func initTracerProvider(ctx context.Context) (*sdktrace.TracerProvider, propagation.TextMapPropagator, cleanup, error) {
	exporter, err := otlptracegrpc.New(ctx, otlptracegrpc.WithInsecure())
	if err != nil {
		return nil, nil, nil, err
	}

	detector := lambdadetector.NewResourceDetector()
	resource, err := detector.Detect(ctx)
	if err != nil {
		return nil, nil, nil, err
	}

	tracerProvider := sdktrace.NewTracerProvider(
		sdktrace.WithBatcher(exporter),

		// https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/services-xray.html
		// > 関数の X-Ray サンプルレートは設定することはできません。
		// sdktrace.WithSampler(),

		sdktrace.WithIDGenerator(xray.NewIDGenerator()),
		sdktrace.WithResource(resource),
	)

	cleanup := func(ctx context.Context) {
		err := tracerProvider.Shutdown(ctx)
		if err != nil {
			log.Fatalf("error shutting down tracer provider: %v", err)
		}
	}

	propagator := xray.Propagator{}

	otel.SetTracerProvider(tracerProvider)
	otel.SetTextMapPropagator(propagator)

	tracer = otel.Tracer(projectName)

	return tracerProvider, propagator, cleanup, nil
}

func createEchoServer(tracerProvider *sdktrace.TracerProvider, propagator propagation.TextMapPropagator) *echo.Echo {
	e := echo.New()

	e.Use(otelecho.Middleware(projectName))

	e.GET("/ping", func(c echo.Context) error {
		ctx := c.Request().Context()

		(func() {
			ctx, span := tracer.Start(ctx, "op1", trace.WithAttributes(attribute.String("id", "foo")))
			defer span.End()

			(func() {
				_, span := tracer.Start(ctx, "op11", trace.WithAttributes(attribute.String("id", "foo")))
				defer span.End()

				time.Sleep(time.Second)
			}())

			(func() {
				_, span := tracer.Start(ctx, "op12")
				defer span.End()

				time.Sleep(time.Second * 2)
			}())
		}())

		return c.JSON(http.StatusOK, map[string]any{"message": "pong"})
	})

	return e
}

func startLambda(server *echo.Echo, tracerProvider *sdktrace.TracerProvider) {
	adapter := echoAdapter.New(server)

	lambda.Start(
		otellambda.InstrumentHandler(
			func(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
				return adapter.ProxyWithContext(ctx, req)
			},
			xrayconfig.WithRecommendedOptions(tracerProvider)...,
		),
	)
}
