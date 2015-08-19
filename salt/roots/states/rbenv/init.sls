rbenv-deps:
  pkg.installed:
    - names:
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

ruby-1.9.3-p429:
  rbenv.installed:
    - default: True
    - require: 
      - pkg: rbenv-deps
