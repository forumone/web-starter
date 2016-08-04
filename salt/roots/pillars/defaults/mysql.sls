{% set mysql_base = salt['pillar.get']('mysql:mysql_version', 'mysql') %}

mysql:
  server:
    root_password: 'web'
  lookup:
    server: {{mysql_base}}-server
    client: {{mysql_base}}
