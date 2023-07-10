#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl status httpd
sudo mkfs.ext4 /dev/sdh
sudo mount /dev/sdh /var/www/html
sudo rm -rf /var/www/html/*
sudo yum install git -y
sudo git clone https://github.com/BhaskarRao-D/Terraform_WebApp-HTML.git  /var/www/html
