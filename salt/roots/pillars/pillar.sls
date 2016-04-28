node:
  version: 4.4.1
  install_from_binary: True
  # Available versions can be found on nodejs.org/dist/
  # checksums are listed in the file SHASUMS256.txt in the respective version’s directory.
  # Package name to look for is nodejs-version-linux-x64.tar.gz
  checksum: f0a53527f52dbcab3b98921a6cfe8613e5fe26fb796624988f6d615c30305a95

## Define custom VCL for project in config/varnish/default.vcl
#varnish:
#  vcl: salt://config/varnish/

mysql:
  mysql_version: mysql56u
  database:
    - web
  user:
    web:
      password: 'web'
      host: localhost
      databases:
        - database: web
          grants: ['all privileges']

php:
  ng:
    php_version: php55u

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

