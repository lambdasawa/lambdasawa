test:
	go test ./...

	cd infra &&\
		terraform fmt &&\
		terraform validate

build: test
	GOOS=linux GOARCH=amd64 go build -o ./bin/app

apply: build
	cd infra &&\
		terraform apply -auto-approve

destroy:
	cd infra &&\
		terraform destroy
