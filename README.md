# Terraform Voting App Deployment

This repository contains Terraform code for deploying the **Voting App** with Docker Swarm on AWS EC2 instances. It sets up the infrastructure and deploys a Docker stack containing the voting app, with the following key components:

- **Manager Node**: Manages the Docker Swarm cluster.
- **Worker Node**: Runs the services of the voting app.

## Prerequisites

- **Terraform**: Ensure you have Terraform installed on your local machine.
- **AWS Account**: Set up an AWS account and configure the necessary credentials.
- **Docker Swarm**: The manager node will initialize Docker Swarm, and the worker node will join the cluster.
- **Security Group**: Open port `80` for the voting app and port `81` to access the voting results.

## Setup and Deployment

1. Clone the repository:

    ```bash
    git clone https://github.com/SerhiiHamretskyi/aws-terraform-voting-app.git
    cd aws-terraform-voting-app
    ```

2. **Configure AWS credentials** (if you haven't already):
    Ensure you have your AWS credentials set up locally. You can use the AWS CLI for this:

    ```bash
    aws configure
    ```

3. **Initialize Terraform**:

    ```bash
    terraform init
    ```

4. **Deploy the infrastructure**:

    ```bash
    terraform apply
    ```

    Terraform will ask for confirmation to proceed. Type `yes` to create the resources.

5. **Accessing the Voting App**:
    - Once the infrastructure is deployed, you can access the voting app through the **Worker Node**'s public IP on port `80`.
    - To view the results of the voting, access the **Worker Node**'s public IP on port `81`.

6. **User Data**:
    - The manager node has user data to initialize Docker Swarm and deploy the voting app stack.
    - The worker node has user data to join the Docker Swarm cluster.

    You can check the Terraform configuration files to see how the user data is set up for both the manager and worker nodes.

## Clean up

To tear down the infrastructure and resources, run:

```bash
terraform destroy
```
### P.S.  
This project was built using the free AWS tier. 