# Drop in dummy www.conf to remove the default pool
/etc/php-fpm.d/www.conf:
  file.managed:
    - source: salt://fpmstack/files/www.conf.dummy
    - makedirs: True

pool_vagrant:
  file.managed:
    - name: /etc/php-fpm.d/vagrant.conf
    - makedirs: True
    - source: salt://fpmstack/files/fpm-pool-template.jinja
    - template: jinja
    - defaults:
        poolname: vagrant
        backlog: 128
        pooluser: vagrant
        poolgroup: vagrant
