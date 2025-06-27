#!/bin/bash
yum update -y
yum install python3 git -y
pip3 install flask
cd /home/ec2-user
git clone https://github.com/your-username/your-repo.git
cd your-repo
nohup python3 app.py &
