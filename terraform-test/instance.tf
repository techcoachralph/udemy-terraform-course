resource "aws_key_pair" "tcr-ssh-keypair" {
  key_name="tcr-ssh-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "tcr_example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.tcr-ssh-keypair.key_name


  provisioner "file" {
    source      = "scripts/ec2-setup.sh"
    destination = "/tmp/ec2-setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ec2-setup.sh",
      "sudo sed -i -e 's/\r$//' /tmp/ec2-setup.sh",
      "sudo /tmp/ec2-setup.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}