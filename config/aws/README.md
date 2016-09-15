Launch a VPC with an EC2 instance.

Defaults:

  - InstanceType: m3.large
  - KeyName: forumone
  - VPC CIDR: 10.0.0.0/16


To Do:

  - Options for CIDR?
  - Default InstanceHostname
  - AWS::EC2::NetworkAclEntry ?
  - Confirm security group settings
  - Termination protection?
  - Volume size?

  - Install salt-minion
    - /bin/sed -i -e 's/#master: salt/master: saltmaster.forumone.com/g' /etc/salt/minion
    - start salt-minion

  - TEST TEST TEST


Sample AWS CLI:
aws cloudformation --region=us-east-1 create-stack --stack-name VPCTEST13 --template-body file:////home//gwilson//git//web-starter//config//aws//f1-aws-cf-ec2.template --capabilities CAPABILITY_IAM --parameters  ParameterKey="KeyName",ParameterValue="MyEC2Key2" ParameterKey="InstanceType",ParameterValue="t1.micro" ParameterKey="InstanceHostname",ParameterValue="vpctest13.byf1.io" --tags Key=client,Value=f1test13

Note: my default aws cli account is a test account, and I am specifying my own KeyName in the --parameters. 