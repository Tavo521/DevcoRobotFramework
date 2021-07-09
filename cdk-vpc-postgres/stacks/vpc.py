from aws_cdk import (
    aws_ec2 as ec2,
    core
)

ec2_type = "t2.micro"
key_name = "key-pair-us-east-1"  # Setup key_name for EC2 instance login
VPC_ID = "vpc-ca4f4cb0"
with open("./user_data/bastion.sh") as f:
    user_data = f.read()

class VpcStack(core.Stack):

    def __init__(self, scope: core.Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)


        if VPC_ID is not None:
            self.vpc = ec2.Vpc.from_lookup(self, 'default-vpc', vpc_id=VPC_ID)
        else: 
            self.vpc = ec2.Vpc(
                self,
                id="VPC",
                cidr="10.0.0.0/16",
                max_azs=2,
                nat_gateways=1,
                subnet_configuration=[
                    ec2.SubnetConfiguration(
                        name="public", cidr_mask=24,
                        reserved=False, subnet_type=ec2.SubnetType.PUBLIC),
                    ec2.SubnetConfiguration(
                        name="private", cidr_mask=24,
                        reserved=False, subnet_type=ec2.SubnetType.PRIVATE),
                    ec2.SubnetConfiguration(
                        name="DB", cidr_mask=24,
                        reserved=False, subnet_type=ec2.SubnetType.ISOLATED
                    ),
                ],
                enable_dns_hostnames=True,
                enable_dns_support=True
            )

            core.Tag(key="Application", value=self.stack_name) \
                .add(self.vpc, key="Application", value=self.stack_name)
        bastion =ec2.Instance(
            self,
            "ec2id",
            instance_type=ec2.InstanceType(instance_type_identifier=ec2_type),
            instance_name="ec2-postgresql-devco",
            machine_image=ec2.MachineImage.generic_linux(ami_map=
                {
                    "us-east-1": "ami-0dc2d3e4c0f9ebd18"
                }
            ),
            vpc=self.vpc,
            vpc_subnets=ec2.SubnetSelection(
                subnet_type=ec2.SubnetType.PUBLIC
            ),
            key_name=key_name,
            user_data=ec2.UserData.custom(user_data)
        )
        bastion.connections.allow_from_any_ipv4(
            ec2.Port.tcp(5432), "Postgresql acess")

        core.CfnOutput(
            self,
            id="VPCId",
            value=self.vpc.vpc_id,
            description="VPC ID",
            export_name=f"{self.region}:{self.account}:{self.stack_name}:vpc-id"
        )

        core.CfnOutput(
            self,
            id="BastionPrivateIP",
            value=bastion.instance_private_ip,
            description="BASTION Private IP",
            export_name=f"{self.region}:{self.account}:{self.stack_name}:bastion-private-ip"
        )

        core.CfnOutput(
            self,
            id="BastionPublicIP",
            value=bastion.instance_public_ip,
            description="BASTION Public IP",
            export_name=f"{self.region}:{self.account}:{self.stack_name}:bastion-public-ip"
        )

        core.CfnOutput(
            self,
            id="BastionDnsName",
            value=bastion.instance_public_dns_name,
            description="dns public name",
            export_name=f"{self.region}:{self.account}:{self.stack_name}:bastion-instance-public-dns-name"
        )