#!/bin/bash
yum update -y
yum install -y python3
aws s3 cp s3://us-west-2-aws-training/awsu-spl/SPL-TF-200-NWCDVW-1/1.0.6.prod/scripts/vpcapp.zip .
unzip vpcapp.zip
cd vpcapp
pip3 install -r requirements.txt
echo $(aws rds describe-db-clusters --region us-east-1 --db-cluster-identifier landmarktecdbcluster --query 'DBClusters[*].DBClusterMembers[?IsClusterWriter==`true`].DBInstanceIdentifier') | awk '{ print substr ($0, 6, length($0)-10) }' > list.txt
export DATABASE_HOST="$(cat list.txt)"
echo $(aws rds describe-db-instances --region us-east-1 --db-instance-identifier $DATABASE_HOST  --query "DBInstances[*].Endpoint.Address") | awk '{ print substr ($0, 4, length($0)-6) }' > list.txt
export DATABASE_HOST="$(cat list.txt)"
#echo $(aws rds describe-db-instances --region us-east-1 --db-instance-identifier $DATABASE_HOST  --query "DBInstances[*].Endpoint.Address") 
#export DATABASE_HOST=labvpcdbcluster-1.cl9ixpihter5.us-east-1.rds.amazonaws.com
export DATABASE_USER=admin
export DATABASE_PASSWORD=testingrdscluster
export DATABASE_DB_NAME=Population
cd loaddatabase
python3 database_populate.py
cd ..
python3 application.py