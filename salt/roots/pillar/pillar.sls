project: vagrant

siteuser:
  - vagrant

memcached:
  memory_cap: 2048
  port: 11211
  max_connections: 1024
  options: -I 2m

php:
  lookup:
    php_pkg: php53u
    apc_pkg: php53u-pecl-apc
    cgi_pkg: php53u-cgi
    cli_pkg: php53u-cli
    curl_pkg: curl
    fpm_pkg: php53u-fpm
    gd_pkg: php53u-gd
    json_pkg: php53u-common
    mbstring_pkg: php53u-mbstring
    mcrypt_pkg: php53u-mcrypt
    memcache_pkg: php53u-pecl-memcache
    memcached_pkg: php53u-pecl-memcached
    mysql_pkg: php53u-mysql
    mysqlnd_pkg: php53u-mysqlnd
    pear_pkg:  php53u-pear
    soap_pkg:  php53u-soap
    fpm_service: php53u-fpm
    xml_pkg:  php53u-xml
    imagick_pkg: php53u-imagick
    suhosin_pkg: php53u-suhosin
    imap_pkg: php53u-imap
    adodb_pkg: php53u-adodb
    pgsql_pkg: php53u-pgsql
    ldap_pkg: php53u-ldap
    php_ini: /etc/php.ini
