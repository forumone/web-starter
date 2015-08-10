project: vagrant

siteuser:
  - vagrant

memcached:
  memory_cap: 512
  port: 11211
  max_connections: 1024
  options: -I 2m

#ius_repo:
#  pkg.installed:
#    - sources:
#      - ius-release: http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-11.ius.centos6.noarch.rpm


php:
  lookup:
    php_pkg: php55
    apc_pkg: php-pecl-apc
    cgi_pkg: php55-cgi
    cli_pkg: php55-cli
    curl_pkg: curl
    fpm_pkg: php-fpm
    gd_pkg: php-gd
    json_pkg: php55-common
    mbstring_pkg: php-mbstring
    mcrypt_pkg: php55-mcrypt
    memcache_pkg: php-pecl-memcache
    memcached_pkg: php-pecl-memcached
    mysql_pkg: php-mysql
    mysqlnd_pkg: php-mysqlnd
    pear_pkg:  php-pear
    soap_pkg:  php55-soap
    fpm_service: php-fpm
    xml_pkg:  php-xml
    imagick_pkg: php55-imagick
    suhosin_pkg: php55-suhosin
    imap_pkg: php55-imap
    adodb_pkg: php55-adodb
    pgsql_pkg: php55-pgsql
    ldap_pkg: php55-ldap
    php_ini: /etc/php.ini
