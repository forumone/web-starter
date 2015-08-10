varnish_repo:
  cmd.run:
    - name: rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-3.0.el6.rpm
    - creates: /etc/yum.repos.d/varnish.repo
