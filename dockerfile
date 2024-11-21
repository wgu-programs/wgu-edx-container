version: 0.2

phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      - aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
  build:
    commands:
      - echo Building the Docker image...
      - docker build -t open-edx-tutor .
      - docker tag open-edx-tutor:latest <aws_account_id>.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/open-edx-tutor:latest
  post_build:
    commands:
      - echo Pushing the Docker image to ECR...
      - docker push <aws_account_id>.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/open-edx-tutor:latest

env:
  variables:
    AWS_DEFAULT_REGION: us-east-1
