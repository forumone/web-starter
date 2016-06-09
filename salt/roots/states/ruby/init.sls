# Grab precompiled ruby versions 

# Set ruby version and download hash from pillar, or a sane default
{% set ruby_version = salt['pillar.get']('ruby:version', 'ruby-2.3.0') %}
{% set pkg_hash = salt['pillar.get']('ruby:pkg_hash', 'md5=fe6d1ccbf47da57c9da5a78f2d90e3f9') %}

download-precompiled-ruby:
  archive.extracted:
    - name: /usr/local
    - source: https://s3.amazonaws.com/pkgr-buildpack-ruby/current/centos-6/{{ ruby_version }}.tgz
    - source_hash: {{ pkg_hash }}
    - tar_options: z
    - archive_format: tar
    - if_missing: /usr/local/bin/ruby

install-ruby-bundler:
  cmd.run:
    - name: /usr/local/bin/gem install bundle
    - unless: test -f /usr/bin/bundle
