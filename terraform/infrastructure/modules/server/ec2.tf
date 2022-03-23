resource "aws_network_interface" "netif" {
  subnet_id       = var.subnet
  private_ips     = [var.instance_ip]
  security_groups = [var.security_group]
}

resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  user_data = <<EOF
#!/usr/bin/env bash
echo "${var.public_key}" >> ~/.ssh/authorized_keys
EOF

  network_interface {
    network_interface_id = aws_network_interface.netif.id
    device_index         = 0
  }
}
