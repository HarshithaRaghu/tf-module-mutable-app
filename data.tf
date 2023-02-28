# Fetches the information of the remote statefile, here in our case, this will fetch the information of the VPC Statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
        bucket = "b52-terraform-state-bucket1"
        key    = "vpc/${var.ENV}/terraform.tfstate"
        region = "us-east-1"
  }
}

# This is to read the information from the tf alb backend module
data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
        bucket = "b52-terraform-state-bucket1"
        key    = "alb/${var.ENV}/terraform.tfstate"
        region = "us-east-1"
  }
}
# This is to read the information of the AMI
data "aws_ami" "lab-image" {
  most_recent      = true
  name_regex       = "b52-ansible-dev-20Jan2023"
  owners           = ["355449129696"]
}



# fetching the metadata of the secret
data "aws_secretsmanager_secret" "secrets" {
  name = "roboshop/secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}