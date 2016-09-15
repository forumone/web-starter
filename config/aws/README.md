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


