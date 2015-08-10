postfix:
  service:
    - dead

#ius_repo:
#  pkg.installed:
#    - sources:
#      - ius-release: http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-11.ius.centos6.noarch.rpm

include:
  - epel

scl-utils:
  pkg.installed

rhscl-php55:
  pkg.installed:
    - sources:
      - rhscl-php55-epel: https://www.softwarecollections.org/en/scls/rhscl/php55/epel-6-x86_64/download/rhscl-php55-epel-6-x86_64-1-2.noarch.rpm
