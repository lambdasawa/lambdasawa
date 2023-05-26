module otel-go-lambda-xray

go 1.19

require (
	github.com/aws/aws-lambda-go v1.34.1
	github.com/awslabs/aws-lambda-go-api-proxy v0.13.3
	github.com/labstack/echo/v4 v4.7.2
	go.opentelemetry.io/contrib/instrumentation/github.com/aws/aws-lambda-go/otellambda v0.34.0
	go.opentelemetry.io/contrib/instrumentation/github.com/aws/aws-lambda-go/otellambda/xrayconfig v0.34.0
	go.opentelemetry.io/contrib/instrumentation/github.com/labstack/echo/otelecho v0.34.0
	go.opentelemetry.io/contrib/propagators/aws v1.9.0
	go.opentelemetry.io/otel v1.9.0
	go.opentelemetry.io/otel/sdk v1.9.0
	go.opentelemetry.io/otel/trace v1.9.0
)

require (
	github.com/cenkalti/backoff/v4 v4.1.3 // indirect
	github.com/go-logr/logr v1.2.3 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/golang-jwt/jwt v3.2.2+incompatible // indirect
	github.com/golang/protobuf v1.5.2 // indirect
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.7.0 // indirect
	github.com/labstack/gommon v0.3.1 // indirect
	github.com/mattn/go-colorable v0.1.12 // indirect
	github.com/mattn/go-isatty v0.0.14 // indirect
	github.com/valyala/bytebufferpool v1.0.0 // indirect
	github.com/valyala/fasttemplate v1.2.1 // indirect
	go.opentelemetry.io/contrib/detectors/aws/lambda v0.34.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/internal/retry v1.9.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.9.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc v1.9.0 // indirect
	go.opentelemetry.io/proto/otlp v0.18.0 // indirect
	golang.org/x/crypto v0.0.0-20220525230936-793ad666bf5e // indirect
	golang.org/x/net v0.0.0-20220617184016-355a448f1bc9 // indirect
	golang.org/x/sys v0.0.0-20220615213510-4f61da869c0c // indirect
	golang.org/x/text v0.3.7 // indirect
	golang.org/x/time v0.0.0-20220609170525-579cf78fd858 // indirect
	google.golang.org/genproto v0.0.0-20211118181313-81c1377c94b1 // indirect
	google.golang.org/grpc v1.48.0 // indirect
	google.golang.org/protobuf v1.28.0 // indirect
)
