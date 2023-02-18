#!/bin/bash

set -xeou pipefail

read TF_BACKEND_BUCKET_NAME
aws s3 mb "s3://$TF_BACKEND_BUCKET_NAME" &&
  aws s3api put-bucket-versioning \
    --bucket "$TF_BACKEND_BUCKET_NAME" \
    --versioning-configuration Status=Enabled &&
  aws s3api put-public-access-block \
    --bucket "$TF_BACKEND_BUCKET_NAME" \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

terraform init \
  -backend-config="bucket=$TF_BACKEND_BUCKET_NAME" \
  -backend-config="key=terraform.tfstate"
terraform plan
