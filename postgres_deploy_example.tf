provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "pg" {
  name        = "postgres"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Be more restrictive in production!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "postgres_server" {
  ami             = "ami-0c55b159cbfafe1f0"  # Example Ubuntu AMI; update for your region/version
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.pg.name]

  key_name = "your_ssh_key_name"  # ensure you've uploaded this key to AWS

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y postgresql postgresql-contrib",
      "sudo systemctl enable postgresql",
      "sudo systemctl start postgresql"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/your_ssh_private_key.pem")
      host        = self.public_ip
    }
  }
}

output "postgres_server_ip" {
  value = aws_instance.postgres_server.public_ip
}
