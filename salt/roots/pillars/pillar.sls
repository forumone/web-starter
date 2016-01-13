project: vagrant

siteuser:
  - vagrant

memcached:
  user: memcached
  daemonize: True
  memory_cap: 128
  port: 11211
  max_connections: 1024
  options: -I 2m

nginx:
  ng:
    vhosts:
      managed:
        vagrant.conf:
          enabled: True
          config:
            - server:
              - server_name: localhost
              - listen:
                - 8080
                - default_server
              - root: /vagrant/public
              - access_log: /var/log/nginx/vagrant.log
              - location /:
                - try_files:
                  - $uri
                  - $uri/index.html
                  - '@rewrite'
              - location @rewrite:
                - rewrite:
                  - ^/(.*)$
                  - /index.php?q=$1
              - location ~ ^/sites/.*/files/(css|js|styles)/:
                - expires: max
                - try_files: $uri @rewrite
              - location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff)$:
                - expires: 1h
              - location ~ \.php$:
                - fastcgi_split_path_info: ^(.+\.php)(/.+)$
                - include: fastcgi_params
                - fastcgi_param: SCRIPT_FILENAME $document_root$fastcgi_script_name
                - fastcgi_intercept_errors: 'on'
                - fastcgi_pass: unix:/var/run/php-fpm/vagrant.sock

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
