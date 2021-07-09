#!/usr/bin/env python3
import os
from aws_cdk import core

from stacks.vpc import VpcStack
from stacks.rds_aurora_serverless import AuroraServerlessStack

# https://docs.aws.amazon.com/cdk/latest/guide/environments.html
env_EU = core.Environment(
    account=os.environ.get("CDK_DEPLOY_ACCOUNT", os.environ["CDK_DEFAULT_ACCOUNT"]),
    region=os.environ.get("CDK_DEPLOY_REGION", os.environ["CDK_DEFAULT_REGION"])
)

app = core.App()

vpc_ec2_stack = VpcStack(
    scope=app,
    id="VPC",
    env=env_EU
)



app.synth()
