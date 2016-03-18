# Mailcatcher via gem installed under vagrant user

{% set ruby_version = salt['pillar.get']('ruby:version', 'ruby-2.0.0-p647') %}

mailcatcher-gem:
  gem.installed:
    - name: mailcatcher
    - user: vagrant
    - ruby: {{ ruby_version }}
