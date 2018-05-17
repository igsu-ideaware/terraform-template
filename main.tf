provider "aws" {
  region = "us-east-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

output "public_ip" {
  value = "${aws_instance.sample.public_ip}"
}

resource "aws_instance" "sample" {
  ami = "ami-43a15f3e"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sample.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello Ideaware!" > index.html
  nohup busybox httpd -f -p "${var.server_port}" &
  EOF

  tags {
    Name = "sample-terraform"
  }
}

resource "aws_security_group" "sample" {
  name = "terraform-sample-security-group"

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}