rbenv-deps:
  pkg.installed:
    - pkgs:
      - bison
      - flex
      - openssl-devel
      - libyaml-devel
      - libffi-devel
      - readline-devel
      - zlib-devel
      - gdbm-devel
      - ncurses-devel
      - tcl-devel
      - tk-devel
      - sqlite-devel
      - gcc
      - make
      - wget
      - tar

# Set ruby version from pillar, or a sane default
{% set ruby_version = salt['pillar.get']('ruby:version', 'ruby-2.0.0-p647') %}

install_ruby_rbenv:
  rbenv.installed:
    - name: {{ ruby_version }}
    - default: True
    - user: vagrant
    - require: 
      - pkg: rbenv-deps

/etc/profile.d/ruby.sh:
  file.managed:
    - source: salt://rbenv/files/ruby.sh
    - mode: 755

install_bundler:
  gem.installed:
    - name: bundler
    - user: vagrant
