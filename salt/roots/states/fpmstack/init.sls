include:
  - fpmstack.pools
  - php.apc
  - php.curl
  - php.fpm
  - php.gd
  - php.mbstring
  - php.memcached
  - php.mysql
  - php.pear
  - php.xml

/var/log/php-fpm:
  file.directory:
    - mode: 755
