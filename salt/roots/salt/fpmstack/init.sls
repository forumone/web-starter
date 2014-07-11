ius_repo:
  pkg.installed:
    - sources:
      - ius-release: http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-11.ius.centos6.noarch.rpm

include:
  - php.apc
  - php.curl
  - php.fpm
  - php.gd
  - php.mbstring
  - php.memcached
  - php.mysql
  - php.pear
  - php.xml
  - fpmstack.pools

/var/log/php-fpm:
  file.directory:
    - mode: 755
