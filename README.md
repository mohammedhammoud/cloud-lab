# AWS Floci Lab

Learning-in-public repo for small AWS + Terraform labs. Most are written for local Floci use, but not every lab was exercised end-to-end in Floci.

## Disclaimer

- Floci emulates AWS locally.
- Behavior can differ from real AWS.
- Some labs were verified in a real AWS account instead of Floci when local support was incomplete.
- This repo is for learning and experimentation, not production.

## Repo structure

```text
projects/
  <lab-name>/
    README.md
    terraform/
tools/
  tf.sh
```

Each lab has:
- a `README.md` with context, test steps, and Floci caveats
- a `terraform/` directory with the actual Terraform config

## Prerequisites

- `floci`
- `terraform`
- `direnv`
- `awscli`
- `python3`
- `node`

## Start Floci

```sh
floci start
direnv allow
aws sts get-caller-identity
```

Expected local values:
- Account: `000000000000`
- Arn: `arn:aws:iam::000000000000:root`
- Endpoint: `http://localhost.floci.io:4566`

## Run a lab

Example:

```sh
cd projects/01-s3-basics
../../tools/tf.sh init
../../tools/tf.sh plan
../../tools/tf.sh apply
../../tools/tf.sh destroy
```

`tools/tf.sh` expects to be run from a lab directory or its `terraform/` subdirectory.

## Labs

- `01-s3-basics` — private S3 bucket, access logging, HTTPS-only bucket policies
- `02-iam-basics` — IAM users, groups, policies, roles, trust policies
- `03-lambda-s3` — S3 event notification invoking Lambda
- `04-ec2-basics` — EC2 instance role, instance profile, user data, S3 access
- `05-vpc-basics` — VPC, public subnet, route table, internet gateway, security group, EC2
- `06-alb-ec2-basics` — ALB, target group, listener, security groups, EC2 backend
- `07-alb-autoscaling` — ALB, launch template, auto scaling group, EC2 backend
- `08-ecs-fargate-alb` — ECS cluster, Fargate service, task definition, ALB backend
- `09-ecs-ec2-alb` — ECS cluster, EC2 capacity, task definition, service, ALB backend
- `10-step-functions` — Step Functions state machine with Lambda invoke workflow
- `11-cloudfront-s3-oac` — CloudFront distribution, private S3 origin, OAC, bucket policy — verified in real AWS
- `12-eventbridge` — EventBridge custom bus, rule, Lambda targets, invoke permissions
- `13-rds-private` — VPC, public EC2, private PostgreSQL RDS, DB subnet group, security groups
- `14-observability` — EC2 observability pipeline with CloudWatch Agent, logs, metrics, dashboard, alarm, and SNS notifications — verified in real AWS
- `15-github-oidc` — GitHub Actions OIDC to AWS with IAM OIDC provider, restricted trust policy, and temporary credentials
- `16-ecs-blue-green` — ECS on EC2 with CodeDeploy Blue/Green deployments, blue and green target groups, ALB traffic switching, and automatic rollback
- `17-sqs-basics` — SQS queue, Lambda consumer, event source mapping, visibility timeout, and basic async message processing

## Security and cost

These labs are intended for local Floci usage.

Do not point them at real AWS without reviewing:
- resources created
- IAM permissions
- networking exposure
- possible cost impact

## CI

GitHub Actions checks:
- `terraform fmt -check -recursive`
- `terraform init -backend=false`
- `terraform validate`

CI only runs static Terraform validation without real AWS credentials. It does not prove end-to-end runtime behavior in Floci or real AWS.
