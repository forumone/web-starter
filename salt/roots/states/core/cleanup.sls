# Miscellanous rules to clean up after ourselves, etc

{% set logdirectories = 'nginx', 'varnish', 'php-fpm' %}

{% for dir in logdirectories %}
logdir-perms-{{dir}}:
  file.directory:
    - name: /var/log/{{ dir }}
    - mode: 755
{% endfor %}

# Install misc packages as required
{% set packages = salt['pillar.get']('extra_packages', False) %}
{% if packages != False %}
install-misc-packages:
  pkg.installed:
    - enablerepo: epel
    - pkgs: {{ packages }}
{% endif %}
