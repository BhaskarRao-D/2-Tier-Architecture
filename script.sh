#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2
sudo mkfs.ext4 /dev/sdh
sudo mount /dev/sdh /var/www/html
sudo rm -rf /var/www/html/*
sudo yum install git -y
sudo git clone https://github.com/BhaskarRao-D/Terraform_WebApp-HTML.git  /var/www/html
