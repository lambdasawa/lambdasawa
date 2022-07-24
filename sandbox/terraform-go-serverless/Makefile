test:
	cd application &&\
		go test ./...

	cd infrastructure &&\
		terraform fmt &&\
		terraform validate &&\
		terraform plan

build: test
	cd application &&\
		GOOS=linux GOARCH=amd64 go build -o ./bin/app

apply: build
	cd infrastructure &&\
		terraform apply -auto-approve

destroy:
	cd infrastructure &&\
		terraform destroy
