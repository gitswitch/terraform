provider "aws" {
    region = "eu-central-1"
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_block[0]
    tags = {
      "Name" = "development"
    }
}

variable "cidr_block" {
    description = "vpc and subnet cidr block"
    type = list(string)
}
resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_block[1]
    availability_zone = "eu-central-1a"
        tags = {
      "Name" = "subnet-1-dev"
    }
}


data "aws_vpc" "existing_vpc" {
    default = true 
}



resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "eu-central-1a"
         tags = {
      "Name" = "default-subnet-2"
    }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}