
## Installation

### Python virtual environment
```
virtualenv aws_cdk.env
cd aws_cdk.env
source bin/activate
```

### Install AWS CDK 
```
npm install -g aws-cdk
cdk --version
cdk --help
```
No harm to read up the docs: https://docs.aws.amazon.com/cdk

### Install the dependencies:
```
pip install aws-cdk.aws-s3
pip install aws-cdk.aws-ec2
pip install aws-cdk.aws-rds
pip install aws-cdk.aws-events-targets
pip install -r requirements.txt
```

When new versions come available, no harm in keeping up to date:
```
pip install --upgrade aws-cdk.core
pip install --upgrade aws-cdk.aws-s3
pip install --upgrade aws-cdk.aws-ec2
pip install --upgrade aws-cdk.aws-rds
pip install --upgrade aws-cdk.aws-events-targets
```

### Set up your AWS profile file ~/.aws/config
```
[profile cdk_profile]
aws_access_key_id=AKIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
region=eu-west-1
```

## Synthesizing the stacks. 

The --no-version-reporting option removes the `AWS::CDK::Metadata` resources and opts out of 
module version reporting to AWS.
. 
```
cdk --profile cdk_profile --no-version-reporting synth VPC AuroraServerless 
```

### Debugging a stack
```
cdk --profile cdk_profile --no-version-reporting synth VPC  > vpc.yaml
aws cloudformation validate-template --template-body file://vpc.yaml 
```

## Deploying the stacks
```
cdk --profile cdk_profile --no-version-reporting deploy VPC AuroraServerless PostgresRDS
```

## Destroying the stacks
```
cdk --profile cdk_profile --no-version-reporting destroy VPC AuroraServerless PostgresRDS
```

### To access the aurora serverless postgres database you've got a few options:

#### 1. Log into the cluster using the AWS console with secrets manager use AuroraServerless.DatabaseSecretArn above
```
https://<region>.console.aws.amazon.com/rds/home?region=<region>#query-editor:/instance/aurora-serverless-postgres-db
```
You can execute SQL directly in the console.

