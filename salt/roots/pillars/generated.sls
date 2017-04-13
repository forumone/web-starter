node:
  version: 4.4.1
  install_from_binary: True
  # Available versions can be found on nodejs.org/dist/
  # checksums are listed in the file SHASUMS256.txt in the respective version’s directory.
  # Package name to look for is nodejs-version-linux-x64.tar.gz
  checksum: f0a53527f52dbcab3b98921a6cfe8613e5fe26fb796624988f6d615c30305a95

java: java-1.8.0-openjdk

elasticsearch:
# Tested versions: 5.3.0, 2.4.2
  version: 5.3.0
  config:
    http.cors.enabled: true
    network.bind_host: 0.0.0.0

mysql:
  mysql_version: mysql56u
  database:
    - web
  user:
    web:
      password: 'web'
      host: '%'
      databases:
        - database: web
          grants: ['all privileges']

php:
  ng:
    php_version: php56u

drush:
  version: '8.x'
