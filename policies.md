<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform  

© Copyright 2022, Intel Corporation

## HashiCorp Sentinel Policies

This file documents the HashiCorp Sentinel policies that apply to this module

## Policy 1

Description: Intel Xeon 3rd Generation Scalable processors (code-named Ice Lake) should be used

Resource type: aws_db_instance

Parameter: instance_class

Allowed Types

- **General Purpose:** db.m6i.large, db.m6i.xlarge, db.m6i.2xlarge, db.m6i.4xlarge, db.m6i.8xlarge, db.m6i.12xlarge, db.m6i.16xlarge, db.m6i.24xlarge, db.m6i.32xlarge
- **Memory Optimized:** db.r6i.large, db.r6i.xlarge, db.r6i.2xlarge, db.r6i.4xlarge, db.r6i.8xlarge, db.r6i.12xlarge, db.r6i.16xlarge, db.r6i.24xlarge, db.r6i.32xlarge

## Policy 2  

Description: Provisioned IOPS SSD (io1) volumes should be used for enhanced performance

Resource type: aws_db_instance

Parameter: storage_type

Allowed Type: io1

## Policy 3  

Description: Database storage encryption should be used

Resource type: aws_db_instance

Parameter: storage_encrypted

Allowed Type: true

## Links

<https://aws.amazon.com/ec2/instance-types/m6i/>

<https://aws.amazon.com/ec2/instance-types/r6i/>

<https://aws.amazon.com/rds/postgresql/pricing/>
