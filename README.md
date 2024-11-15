# Using CloudFormation for managing and deploying AWS infrastructure

## 👐 Overview

This nested CloudFormation template creates EC2 instances within a VPC that includes both public and private subnets. It manages the infrastructure by creating multiple nested stacks for the VPC, NAT Gateway, route tables, security groups and EC2 instances.

## ✍️ Prerequisites

- An AWS account with permissions to create VPC, EC2, S3, and CloudFormation resources.
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#:~:text=Install%20or%20update%20the%20%20AWS%20CLI%201,--version%20command.%20C%3A%5C%3E%20%20aws%20--version%20%20 "AWS CLI") or AWS Management Console to deploy the template.
- Access to an **S3 bucket** where you'll upload the nested stack templates for use during deployment.

## 👀 Template Structure

- **AWSTemplateFormatVersion**: The version of the template format.
- **Description**: A description of the template and its functionality.
- **Parameters**: Inputs required for the template to customize the stack according to your requirements.
- **Resources**: AWS resources that will be created.
- **Outputs**: Values that will be outputted after deployment.

<br>

<p align="center">
    <img src="./images/nested-stack.png" alt="CloudFormation nested stacks"></img>
</p>

## 🔥 Getting Started

### Step 1: Configure AWS CLI

Before deploying, ensure your AWS CLI is configured to use a specified profile:

```bash
aws configure --profile your-profile-name
```

> :memo: Replace ```your-profile-name``` with the appropriate profile that has the necessary permissions.

### Step 2: Clone the repository

```bash
git clone https://github.com/NT548-P11-DevOps-Technology/assignment-lab01-cloudformation.git
```

### Step 3: Upload Nested Stack Templates to S3

To deploy nested CloudFormation stacks, you must upload the templates to an S3 bucket. You can use the following steps to upload templates from your local system to an S3 bucket:

1. Modify the S3 bucket name in the [aws-s3-cp.sh](./aws-s3-cp.sh) (Linux) or [aws-s3-cp.bat](./aws-s3-cp.bat) (Windows) scripts.

    Replace the **S3_BUCKET** placeholder in the script with your actual S3 bucket name: <br>
    ```S3_BUCKET=your-bucket-name```

2. Run the respective script depending on your operating system:

- For Linux/Mac:
```bash
bash aws-s3-cp.sh
```

- For Windows:
```
.\aws-s3-cp.bat
```

This will upload all the nested stack templates to your S3 bucket.

<p align="center">
    <img src="./images/store-template-in-s3.png" alt="Template files stored in S3"></img>
</p>

### Step 4: Deploy the CloudFormation Stack

To deploy the stack, use the following AWS CLI command to launch the CloudFormation template from your S3 bucket:

```bash
aws cloudformation deploy --template-file ./root_stack.yml --stack-name your-stack-name --profile your-profile-name
```

**Note:**
- ```your-stack-name```: A name for the CloudFormation stack.
- ```your-bucket-name```: The name of your S3 bucket where the templates are stored.
- ```your-profile-name```: The AWS CLI profile that has the appropriate permissions to create the stack.

### Step 5: Monitor Stack Creation

Once the stack creation starts, you can monitor its progress from the AWS Management Console or using the AWS CLI:

```bash
aws cloudformation describe-stacks --stack-name your-stack-name --profile your-profile-name
```

You can also check the AWS CloudFormation console for detailed information about the stack's status and to troubleshoot any errors.

<p align="center">
    <img src="./images/stack-status.png" alt="Stack's status"></img>
</p>

<p align="center">
    <img src="./images/stack-events.png" alt="Stack's events"></img>
</p>

## 🗣 Notice

When working with security groups, it's essential to customize the **`SSHLocation`** parameter in [the security groups template](./security_groups/security_groups.yml) to allow SSH access from your specific public IP address. The default setting in this template is a placeholder (`103.129.191.120/32`), which should be replaced with your own **public IP address** to ensure that only authorized users can access your EC2 instances over SSH.

Find your public IP address via Google search [**"What is my IP?"**](https://whatismyipaddress.com/) or enter this command in your terminal:

```bash
curl ifconfig.io
```
