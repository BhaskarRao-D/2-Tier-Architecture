resource "aws_instance" "web-server" {

  ami                    = "ami-03c7c1f17ee073747"
  instance_type          = "t2.micro"
  count                  = 2
  key_name               = "PG"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = element(["subnet-0948f11e16ac02313", "subnet-000752aac692410af"], count.index)
  user_data              = <<-EOF

          #!/bin/bash
          sudo yum update -y
          sudo amazon-linux-extras install nginx1 -y 
          sudo systemctl enable nginx
          sudo systemctl start nginx
   EOF

  tags = {
    Name = "instance-${count.index}"
  }
}
