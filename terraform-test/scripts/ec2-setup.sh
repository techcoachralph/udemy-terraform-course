#! /bin/bash

#sudo su - ec2-user

# yum update
sudo yum update

# search for docker
sudo yum search docker

# get docker info to install
sudo yum info docker

# install docker (pass to bypass installation confirmation)
sudo yum install docker -y

# add group membership to the default ec2-user
sudo usermod -a -G docker ec2-user

#id ec2-user

#newgrp docker

## installing docker-compose

# installing pip
sudo yum install python3-pip -y

# install docker compose without root access
pip3 install --user docker-compose

## enable docker services
# enable when AMI boots
sudo systemctl enable docker.service

# start docker now
sudo systemctl start docker.service

# run docker container for selenium grid
sudo docker run --rm -it -d -p 4444:4444 -p 7900:7900 --shm-size 2g selenium/standalone-chrome