{% set php_base = salt['pillar.get']('php:ng:php_version', 'php') %}

php:
  ng:
    lookup:
      pkgs:
        php:
          - {{php_base}}-cli
          - {{php_base}}-pdo
          - {{php_base}}-gd
          - {{php_base}}-pecl-memcached
          - {{php_base}}-xml
          - {{php_base}}-mysqlnd
          - {{php_base}}-mbstring
          - {{php_base}}-process
          - {{php_base}}-mcrypt
          - {{php_base}}-soap
          - {{php_base}}-common
          - {{php_base}}-opcache
          - {{php_base}}-pecl-xdebug
          - {{php_base}}-bcmath
        fpm:
          - {{php_base}}-fpm
