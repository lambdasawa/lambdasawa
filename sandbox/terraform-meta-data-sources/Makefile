BUCKET_NAME := lamb-sbx-terraform-meta-data-sources-tfstate

PARAMETER_NAME := /github.com/lambdasawa/lambdasawa/sandbox/terraform-meta-data-sources

SECRET_NAME := lamb-sbx-terraform-meta-data-sources

.PHONY: setup
setup:
	aws s3 ls "s3://${BUCKET_NAME}" ||\
		aws s3 mb "${BUCKET_NAME}" &&\
		aws s3api put-bucket-versioning \
			--bucket  "${BUCKET_NAME}" \
			--versioning-configuration Status=Enabled &&\
		aws s3api put-public-access-block \
			--bucket "${BUCKET_NAME}" \
			--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

	aws ssm get-parameter --name "${PARAMETER_NAME}" --with-decryption ||\
		aws ssm put-parameter --name "${PARAMETER_NAME}" --value "foo" --type SecureString --overwrite
	aws secretsmanager get-secret-value --secret-id "${SECRET_NAME}" ||\
		aws secretsmanager create-secret --name "${SECRET_NAME}" --secret-string "{\"TEST\":\"TEST\"}"

.PHONY: init
init: setup
	terraform init \
		-backend-config="bucket=${BUCKET_NAME}" \
		-backend-config="key=terraform.tfstate"

.PHONY: deploy
deploy: init
	terraform apply -auto-approve
	echo 'jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.main.secret_string))' | terraform console
	echo 'nonsensitive(data.aws_ssm_parameter.main.value)' | terraform console

.PHONY: destroy
destroy: init
	terraform destroy -auto-approve

.PHONY: listwbuckets
list-buckets:
	aws s3 ls | rg lamb-terraform-metadata-sources
