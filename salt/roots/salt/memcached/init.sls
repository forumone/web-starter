memcached:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: memcached
    - watch: 
      - file: /etc/sysconfig/memcached
  
/etc/sysconfig/memcached:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - source: salt://memcached/templates/sysconfig-memcached
    - template: jinja
    - require:
      - pkg: memcached
