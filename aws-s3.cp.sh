#!/bin/bash
S3_BUCKET="group03-s3-bucket"
AWS_PROFILE="aws-learner-lab"

aws s3 cp ./vpc/vpc.yaml s3://$S3_BUCKET --profile $AWS_PROFILE
aws s3 cp ./nat_gateway/nat_gateway.yml s3://$S3_BUCKET --profile $AWS_PROFILE
aws s3 cp ./route_tables/route_tables.yml s3://$S3_BUCKET --profile $AWS_PROFILE
aws s3 cp ./security_groups/security_groups.yml s3://$S3_BUCKET --profile $AWS_PROFILE
aws s3 cp ./ec2/ec2.yaml s3://$S3_BUCKET --profile $AWS_PROFILE

echo "Files uploaded to S3 bucket"