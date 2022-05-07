project = "python"

app "flask" {
  build {
    use "docker" {
      buildkit   = true
      platform = "arm64"
      dockerfile = "${path.app}/Dockerfile"
    }

    registry {
      use "aws-ecr" {
        region     = var.region
        repository = "python-flask"
        tag        = var.tag
      }
    }
  }

  deploy {
    use "aws-lambda" {
      region = var.region
      memory = 512
    }
  }

  release {
    use "lambda-function-url" {

    }
  }
}

variable "tag" {
  default     = "latest"
  type        = string
  description = "A tag"
}

variable "region" {
  default     = "us-east-1"
  type        = string
  description = "AWS Region"
}