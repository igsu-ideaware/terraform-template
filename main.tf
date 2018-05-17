provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sample" {
  ami = "ami-43a15f3e"
  instance_type = "t2.micro"
  
  tags {
    Name = "sample-terraform"
  }
}
