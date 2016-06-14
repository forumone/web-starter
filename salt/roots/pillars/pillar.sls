node:
  version: 4.4.1
  install_from_binary: True
  # Available versions can be found on nodejs.org/dist/
  # checksums are listed in the file SHASUMS256.txt in the respective version’s directory.
  # Package name to look for is nodejs-version-linux-x64.tar.gz
  checksum: f0a53527f52dbcab3b98921a6cfe8613e5fe26fb796624988f6d615c30305a95

## Define custom VCL for project in config/custom/varnish/default.vcl, backends.vcl, secret, etc.
#varnish:
#  vcl: salt://custom/varnish/

# TODO
#solr:
#  sonf: salt://custom/solr-conf

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
    php_version: php56u

drush:
  version: '8.x'
  
{% include 'nginx/drupal.sls' %}
