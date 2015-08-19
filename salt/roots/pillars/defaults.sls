# Ruby formula defaults for Vagrant
ruby:
  version: ruby-2.0.0-p647

# Nginx formula defaults for Vagrant
nginx:
  ng:
    # PPA installing
    install_from_ppa: False
    # Set to 'stable', 'development' (mainline), 'community', or 'nightly' for each build accordingly ( https://launchpad.net/~nginx )
    ppa_version: 'stable'
    
    # These are usually set by grains in map.jinja
    lookup:
      vhost_use_symlink: False
      # This is required for RedHat like distros (Amazon Linux) that don't follow semantic versioning for $releasever
      rh_os_releasever: '6'

    # Source compilation is not currently a part of nginx.ng
    from_source: False

    package:
      opts: {} # this partially exposes parameters of pkg.installed

    service:
      enable: True # Whether or not the service will be enabled/running or dead
      opts: {} # this partially exposes parameters of service.running / service.dead

    server:
      opts: {} # this partially exposes file.managed parameters as they relate to the main nginx.conf file

      # nginx.conf (main server) declarations
      # dictionaries map to blocks {} and lists cause the same declaration to repeat with different values
      config: 
        worker_processes: 1
        pid: /var/run/nginx.pid
        events:
          worker_connections: 1024
        http:
          # General Global settings
          sendfile: 'on'
          tcp_nopush: 'on'
          tcp_nodelay: 'on'
          keepalive_timeout: 65
          gzip: 'on'
          gzip_min_length: 1000
          gzip_types: text/plain text/css application/x-javascript application/xml application/octet-stream application/javascript
          gzip_proxied: any
          client_max_body_size: 0
          client_body_buffer_size: 2m
          server_names_hash_max_size: 1024
          fastcgi_read_timeout: 14400s
          fastcgi_buffer_size: 128k
          fastcgi_buffers: 4 256k
          fastcgi_busy_buffers_size: 256k
          proxy_buffer_size: 128k
          proxy_buffers: 4 256k
          proxy_busy_buffers_size: 256k

          # IP Handling (Varnish / proxies)
          set_real_ip_from: 0.0.0.0/0
          real_ip_header: X-Forwarded-For
          
          # SSL Defaults
          ssl_protocols: TLSv1 TLSv1.1 TLSv1.2
          ssl_ciphers: 'AES256+EECDH:AES256+EDH'
          ssl_prefer_server_ciphers: 'on'
          ssl_session_cache: shared:SSL:10m
#          ssl_dhparam: /etc/nginx/ssl/dhparam.pem
          
          include:
            - /etc/nginx/mime.types
            - /etc/nginx/conf.d/*.conf

    vhosts:
      disabled_postfix: .disabled # a postfix appended to files when doing non-symlink disabling
      symlink_opts: {} # partially exposes file.symlink params when symlinking enabled sites
      rename_opts: { force: True } # partially exposes file.rename params when not symlinking disabled/enabled sites
      managed_opts: {} # partially exposes file.managed params for managed vhost files
      dir_opts: {} # partially exposes file.directory params for site available/enabled dirs

      # vhost declarations
      # vhosts will default to being placed in vhost_available
      managed:
        default.conf: # relative pathname of the vhost file
          # may be True, False, or None where True is enabled, False, disabled, and None indicates no action
          enabled: True
          
          # May be a list of config options or None, if None, no vhost file will be managed/templated
          # Take server directives as lists of dictionaries. If the dictionary value is another list of
          # dictionaries a block {} will be started with the dictionary key name
          config: 
            - '# disabled'
