#!/bin/bash

MY_SSH="$HOME/.ssh/id_rsa_level3"

cd ~/aws-devops-level3

cat << "EOF" > user-data.web.sh
#!/bin/bash

yum -y update && yum -y upgrade

yum install nginx -y
service nginx start

yum -y install git-core

rm -rf hello-me
git clone https://github.com/nenemustafa/Hellome.git

rm -f /usr/share/nginx/html/*.html
cp hello-me/html/* /usr/share/nginx/html/
EOF

terraform plan -out=tfplan
terraform apply "tfplan"

export MY_EC2=$(terraform output -json | jq -r .ec2_public_dns_name.value)

ssh -i $MY_SSH ec2-user@$MY_EC2 sudo tail -f /var/log/cloud-init-output.log