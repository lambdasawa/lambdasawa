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

var tracer trace.Tracer

func main() {
	ctx := context.Background()

	tracerProvider, propagator, cleanup, err := initTracerProvider(ctx)
	if err != nil {
		panic(err)
	}

	defer cleanup(ctx)

	initTracer()

	e := buildEcho(tracerProvider, propagator)

	listen(e, tracerProvider)
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

	return tracerProvider, propagator, cleanup, nil
}

func initTracer() {
	tracer = otel.Tracer("sandbox-otel-go-lambda-xray")
}

func buildEcho(tracerProvider *sdktrace.TracerProvider, propagator propagation.TextMapPropagator) *echo.Echo {
	e := echo.New()

	e.Use(
		otelecho.Middleware(
			"my-server",
		),
	)

	e.GET("/ping", pingHandler)

	return e
}

func pingHandler(c echo.Context) error {
	ctx := c.Request().Context()

	log.Println("ping")

	(func() {
		_, span := tracer.Start(ctx, "op1", trace.WithAttributes(attribute.String("id", "foo")))
		defer span.End()

		time.Sleep(time.Second)
	}())

	(func() {
		_, span := tracer.Start(ctx, "op2")
		defer span.End()

		time.Sleep(time.Second * 3)
	}())

	return c.JSON(http.StatusOK, map[string]interface{}{
		"message": "pong",
	})
}

func listen(e *echo.Echo, tracerProvider *sdktrace.TracerProvider) {
	echoLambda := echoAdapter.New(e)

	lambda.Start(
		otellambda.InstrumentHandler(
			func(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
				return echoLambda.ProxyWithContext(ctx, req)
			},
			xrayconfig.WithRecommendedOptions(tracerProvider)...,
		),
	)
}
