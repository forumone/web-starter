{% set php_base = salt['pillar.get']('php:ng:php_version', 'php') %}

php:
  ng:
    lookup:
      pkgs:
        php:
          - {{php_base}}-cli
          - {{php_base}}-pdo
          - {{php_base}}-gd
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
# Handle php 7 not including a pecl-memcached package
{% if 'php7' in php_base %}
          - {{php_base}}-json
{% else %}
          - {{php_base}}-pecl-memcached
{% endif %}
        fpm:
          - {{php_base}}-fpm
