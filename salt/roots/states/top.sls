base:
  '*':
    - core
#    - epel
    - jinja26
#    - rbenv
#    - node
#    Load mysql.client first to avoid getting mysql-libs from base repo
    - mysql.client
    - mysql
    - memcached.config
    - varnish
#    - mailcatcher
    - nginx.ng
    - php.ng
    - php.ng.fpm
