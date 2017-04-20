base:
  '*':
    - core
    - epel
    - jinja26
#    - node
#    - node.npm-install
#    - ruby
##    Load mysql.client first to avoid getting mysql-libs from base repo
#    - mysql.client
#    - mysql
#    - memcached.config
#    - nginx.ng
#    - varnish.repo
#    - varnish
#    - php.ng
#    - php.ng.cli.ini
#    - php.ng.fpm.pools
#    - composer
#    - drush
#    - solr.v4
#    - mailhog
    - java
    - elasticsearch
    - core.cleanup

