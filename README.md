# Terraform Infrastructure Deployment

This repository contains Terraform scripts for deploying a highly available infrastructure on AWS. The infrastructure includes the following components:

- Virtual Private Cloud (VPC) with public and private subnets across two Availability Zones
- Application Load Balancer (ALB) deployed in the public subnets
- Elastic Container Service (ECS) cluster running on EC2 instances in the private subnets
- S3 bucket configured for static website hosting

## Security Measures

The following security measures have been implemented:

- The ECS cluster and instances are deployed in private subnets, ensuring that they are not directly accessible from the internet.
- The ALB is deployed in public subnets and acts as the entry point for incoming traffic, forwarding requests to the ECS cluster.
- Security groups are configured to allow only necessary inbound and outbound traffic.
- The S3 bucket for website hosting is configured with public read access, but write access is restricted.

## Deploying to Multiple Environments

This project is designed to support multiple environments (e.g., dev, staging, prod) using Terraform workspaces. Workspaces allow you to manage multiple state files for different environments within the same Terraform configuration.

To deploy to a specific environment, follow these steps:

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Create a new workspace or switch to an existing one:
   ```
   terraform workspace new dev
   # or
   terraform workspace select dev
   ```

3. Plan and apply the changes:
   ```
   terraform plan
   terraform apply
   ```

To switch between environments, use the `terraform workspace select` command and specify the desired environment name.

# CI/CD
A a GitHub Actions workflow file that defines a continuous integration and deployment (CI/CD) pipeline for Terraform configurations. It automates the process of initializing Terraform, planning the changes, and applying the configurations across different environments (dev, staging, and prod)

## Cost Estimation

The cost of this deployment will vary based on the number of requests, the instance types used for the ECS cluster, and the amount of data transfer. Here's a rough estimate of the costs:

- **ECS Cluster**: The cost will depend on the instance types and the number of instances running in the cluster. For example, using `t3.medium` instances with an average of 5 instances running, the cost would be approximately $50 per month.
- **Application Load Balancer**: The cost of the ALB is based on the number of load balancer capacity units (LCUs) used. For a typical deployment, the cost would be around $20 per month.
- **S3 Bucket**: The cost of the S3 bucket for website hosting is based on the amount of data stored and the number of requests. For a small website with moderate traffic, the cost would be around $5 per month.
- **Data Transfer**: The cost of data transfer will depend on the amount of traffic your website receives. AWS charges $0.09 per GB for data transfer out of the AWS network.

## Cost Optimization

To optimize costs, you can consider the following strategies:

- **Autoscaling**: Implement automatic scaling for the ECS cluster to automatically scale the desired count of tasks based on demand to reduce costs during periods of low utilization. 
- **Savings Plans**: If you have a consistent workload, you can purchase Savings Plans or Reserved Instances for the ECS cluster, which can provide significant cost savings compared to On-Demand instances.
- **CloudFront**: Use Amazon CloudFront as a content delivery network (CDN) for your static website hosted on S3. This can reduce data transfer costs and improve performance for users around the world.
- **Launch Type**: The use of EC2 gives an alternative to Fargate where the compute pricing is fixed based on the number of instance running within the cluster. Depending on the traffic, this may be more cost efficient  


## Handling Future Changes

As your application grows and requirements change, you may need to make modifications to the infrastructure. Here's how you can handle future changes:

1. **Modular Approach**: The Terraform scripts in this project follow a modular approach, with each component (VPC, ECS cluster, ALB, etc.) defined in separate modules. This makes it easier to update or replace individual components without affecting the entire infrastructure.

2. **Version Control**: Use a version control system like Git to track changes to your Terraform scripts. This allows you to collaborate with team members, review changes, and roll back to previous versions if needed.

3. **Testing**: Implement a testing strategy for your Terraform scripts to ensure that changes don't introduce any issues or regressions. You can use tools like Terraform Cloud or GitHub Actions to automate testing and deployment.


# Additional considerations for the future

1. Store your Terraform state files in a remote backend
2. Consider using an Amazon CloudFront distribution to serve the static website hosted on the Amazon S3 bucket to potentially decrease latency, cost and increase the security of your application
3. Implement monitoring and alerting to identify and address any issues.