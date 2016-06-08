# Set a role for varnish
set-varnish-role:
  grains.list_present:
    - name: roles
    - value: varnish

varnish:
  pkg:
    - installed
    - enablerepo: varnish-3.0
  service:
    - enable: True
    - running
    - watch:
      - file: /etc/varnish

/etc/varnish:
  file.recurse:
    - source: {{ salt['pillar.get']('varnish:vcl', 'salt://varnish/files') }}
    - user: root

/etc/sysconfig/varnish:
  file.managed:
    - source: salt://varnish/files/sysconfig-varnish
    - template: jinja
    - watch_in:
      - service: varnish
    - context:
        port: {{ salt['pillar.get']('varnish:port', '80') }}
        memory: {{ salt['pillar.get']('varnish:memory', '500M') }}

/etc/varnish/secret:
  file.managed:
    - mode: 644
    - replace: False

/var/log/varnish:
  file.directory:
    - mode: 755
    - user: root
    - group: vagrant
