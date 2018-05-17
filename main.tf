provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sample" {
  ami = "ami-43a15f3e"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sample.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello Ideaware!" > index.html
  nohup busybox httpd -f -p 8080 &
  EOF

  tags {
    Name = "sample-terraform"
  }
}

resource "aws_security_group" "sample" {
  name = "terraform-sample-security-group"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}