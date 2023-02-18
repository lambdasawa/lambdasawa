remote_state {
  backend = "s3"
  config = {
    bucket  = get_env("TF_BACKEND_BUCKET_NAME")
    key     = "${path_relative_to_include()}.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}

generate "main" {
  path      = "_main.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("../main.tf")
}
