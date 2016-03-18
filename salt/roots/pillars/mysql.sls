{% set mysql_base = salt['pillar.get']('mysql:mysql_version', 'mysql') %}

mysql:
  lookup:
    server: {{mysql_base}}-server
    client: {{mysql_base}}
