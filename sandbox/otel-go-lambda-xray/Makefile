.PHONY: deploy
deploy:
	mkdir -p dist/
	env GOOS=linux GOARCH=amd64 go build -o dist/bootstrap
	zip -rj dist/lambda.zip dist/bootstrap
	terraform init
	terraform apply -auto-approve
