# Miscellanous rules to clean up after ourselves, etc

{% set logdirectories = 'nginx', 'varnish', 'php-fpm' %}

{% for dir in logdirectories %}
logdir-perms-{{dir}}:
  file.directory:
    - name: /var/log/{{ dir }}
    - mode: 755
{% endfor %}
