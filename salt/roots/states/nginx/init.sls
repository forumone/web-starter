{% set site = pillar['project'] %}

nginx_repo:
  pkg.installed:
    - sources: 
      - nginx-release-centos: http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm

nginx:
  pkg:
    - installed
    - fromrepo: nginx
  service:
    - running
    - enable: True
    - require:
      - pkg: nginx
      - file: /var/cache/nginx/microcache
    - watch: 
      - file: /etc/nginx

/var/cache/nginx/microcache:
  file:
    - directory
    - user: nginx
    - group: nginx
    - mode: 750
    - makedirs: True

/var/log/nginx:
  file:
    - directory
    - user: nginx
    - group: nginx
    - mode: 755
    - makedirs: True

/etc/nginx:
  file.recurse:
    - source: salt://sites/{{ site }}/nginx
    - owner: root
    - group: root
    - template: jinja
    - include_empty: True

{% if pillar.get('ssl_key') %}
/etc/nginx/ssl/server.key:
  file.managed:
    - mode: 600
    - source: salt://sites/{{ site }}/nginx/ssl/server.key
    - template: jinja
{% endif %}

{% for siteuser in pillar['siteuser'] %}
usermod -a -G {{ siteuser }} nginx:
  cmd.run
{% endfor %}
