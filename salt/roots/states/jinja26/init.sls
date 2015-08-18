python-jinja2-26:
  pkg.installed

/etc/profile.d/salt-jinja.sh:
  file.managed:
    - source: salt://jinja26/salt-jinja.sh
    - mode: 755
    - require: 
      - pkg: python-jinja2-26
