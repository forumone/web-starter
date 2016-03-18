postfix:
  service:
    - dead

remove-stock-mysql-libs:
  pkg.removed:
    - name: mysql-libs

ius_repo:
  pkg.installed:
    - sources:
      - ius-release: http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-14.ius.centos6.noarch.rpm

disable_iptables:
  service:
    - name: iptables
    - dead
    - enable: False
