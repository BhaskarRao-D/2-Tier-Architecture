resource "aws_instance" "web-server" {

  ami             = "ami-03c7c1f17ee073747"
  instance_type   = "t2.micro"
  count           = 2
  key_name        = "PG"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id     = element(["subnet-05f83ee6878f655fe", "subnet-0c39950517eeae01b"], count.index)
  user_data       = <<-EOF

   #!/bin/bash
   sudo su 
   yum update -y
   yum install httpd -y
   systemctl start httpd
   systemctl stats httpd
   EOF

  tags = {
    Name = "instance-${count.index}"
  }
}
