postfix:
  service:
    - dead

ius_repo:
  pkg.installed:
    - sources:
      - ius-release: http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-14.ius.centos6.noarch.rpm

include:
  - epel
