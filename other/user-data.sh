#!/bin/bash

REGION=us-east-1
TABLE_NAME=revolent-tower-dev

yum update -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source /.nvm/nvm.sh
nvm install 14
echo "export REGION=$REGION" >> ~/.bashrc
echo "export TABLE_NAME=$TABLE_NAME" >> ~/.bashrc
source ~/.bashrc
npm install -g pm2
aws s3 cp s3://temp19012023/revolent-tower-student-code.zip /var
unzip /var/revolent-tower-student-code.zip -d /var
cd /var/revolent-tower-student-code/frontend
npm ci
npm run build
cd /var/revolent-tower-student-code/backend
npm ci
pm2 start server.js
