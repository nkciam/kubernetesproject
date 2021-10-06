provider "aws" {
  region     = var.AWS_REGION
  access_key = "AKIAR6U34AB36W2QXKLK"
  secret_key = "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"

}

# aws_region provider details about a specific AWS region
data "aws_region" "current" {
}

# The Availability Zone data source allows access to the list of AWS Availability Zone,
# which can be accessed by an AWS account within the region configured in the provider.
data "aws_availability_zones" "available" {
}

# The HTTP provider is a utility provider for interacting with generic HTTP servers as part of Terraforn configuration
provider "http"{
}