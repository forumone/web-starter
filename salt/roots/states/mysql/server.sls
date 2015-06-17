mysql-server: 
  pkg:
    - installed
    - name: mysql-server
  service: 
    - enable: True
    - running
    - name: mysqld
    - watch:
      - file: /etc/my.cnf

/etc/my.cnf:
  file.managed:
    - source: salt://mysql/conf/my.cnf
    - template: jinja
    - user: root
    - group: root
    - mode: 640 
    - defaults:
        max_allowed_packet: 16m
        tmp_table_size: 64m
        table_open_cache: 8096
        query_cache_size: 64m
        thread_cache_size: 4
        innodb_buffer_pool_size: 1g
        innodb_flush_log_at_trx_commit: 0
