MySQL-python:
  pkg.installed
 
db_web:
  mysql_database.present:
    - name: web
  mysql_user.present:
    - host: localhost
    - password: web
  mysql_grants.present:
    - grant: all privileges
    - database: web.*
    - user: web
    - host: localhost
