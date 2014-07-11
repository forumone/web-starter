include:
  - memcached

python-memcached:
  pkg:
    - installed
    - require:
      - pkg: memcached
