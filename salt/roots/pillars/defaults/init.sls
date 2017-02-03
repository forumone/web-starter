include:
  - defaults.mysql
  - defaults.phpng

# Default memcached settings.
memcached:
  user: memcached
  daemonize: True
  memory_cap: 128
  port: 11211
  max_connections: 1024
  options: -I 2m

# Default mysqld server settings
mysql:
  server:
    root_password: ''
    mysqld:
      bind-address: 0.0.0.0
      port: 3306
      skip-name-resolve: noarg_present
      thread-cache-size: 16
      table-open-cache: 4096
      table-definition-cache: 2048
      query-cache-size: 64M
      query-cache-limit: 1M
      sort-buffer-size: 1M
      read-buffer-size: 1M
      read-rnd-buffer-size: 1M
      join-buffer-size: 1M
      tmp-table-size: 128M
      max-heap-table-size: 128M
      max-connections: 20
      max-allowed-packet: 128M
      interactive-timeout: 3600
      default-storage-engine: InnoDB
      innodb-buffer-pool-size: 512M
      innodb-log-buffer-size: 8M
      innodb-log-file-size: 128M
      innodb-file-per-table: 1
      innodb-open-files: 300
      innodb_flush_log_at_trx_commit: 0
    mysql:
      max-allowed-packet: 128M

# Ruby formula defaults for Vagrant
#ruby:
#  version: ruby-2.0.0-p647

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
        user: nginx
        worker_processes: 1
        pid: /var/run/nginx.pid
        events:
          worker_connections: 1024
        http:
          # General Global settings
          sendfile: 'off'
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

    certificates:
      'vagrant':
        public_cert: |
          -----BEGIN CERTIFICATE-----
          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
          NlaPzdZqvAzGzsKl0nCU
          -----END CERTIFICATE-----
          -----BEGIN CERTIFICATE-----
          MIIETTCCAzWgAwIBAgIDAjpxMA0GCSqGSIb3DQEBCwUAMEIxCzAJBgNVBAYTAlVTMRYwFAYDVQQK
          Ew1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVzdCBHbG9iYWwgQ0EwHhcNMTMxMjExMjM0
          NTUxWhcNMjIwNTIwMjM0NTUxWjBCMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5j
          LjEbMBkGA1UEAxMSUmFwaWRTU0wgU0hBMjU2IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
          CgKCAQEAu1jBEgEul9h9GKrIwuWF4hdsYC7JjTEFORoGmFbdVNcRjFlbPbFUrkshhTIWX1SG5tmx
          2GCJa1i+ctqgAEJ2sSdZTM3jutRc2aZ/uyt11UZEvexAXFm33Vmf8Wr3BvzWLxmKlRK6msrVMNI4
          /Bk7WxU7NtBDTdFlodSLwWBBs9ZwF8w5wJwMoD23ESJOztmpetIqYpygC04q18NhWoXdXBC5VD0t
          A/hJ8LySt7ecMcfpuKqCCwW5Mc0IW7siC/acjopVHHZDdvDibvDfqCl158ikh4tq8bsIyTYYZe5Q
          Q7hdctUoOeFTPiUs2itP3YqeUFDgb5rE1RkmiQF1cwmbOwIDAQABo4IBSjCCAUYwHwYDVR0jBBgw
          FoAUwHqYaI2J+6sFZAwRfap9ZbjKzE4wHQYDVR0OBBYEFJfCJ1CewsnsDIgyyHyt4qYBT9pvMBIG
          A1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6
          Ly9nMS5zeW1jYi5jb20vY3Jscy9ndGdsb2JhbC5jcmwwLwYIKwYBBQUHAQEEIzAhMB8GCCsGAQUF
          BzABhhNodHRwOi8vZzIuc3ltY2IuY29tMEwGA1UdIARFMEMwQQYKYIZIAYb4RQEHNjAzMDEGCCsG
          AQUFBwIBFiVodHRwOi8vd3d3Lmdlb3RydXN0LmNvbS9yZXNvdXJjZXMvY3BzMCkGA1UdEQQiMCCk
          HjAcMRowGAYDVQQDExFTeW1hbnRlY1BLSS0xLTU2OTANBgkqhkiG9w0BAQsFAAOCAQEANevhiyBW
          lLp6vXmp9uP+bji0MsGj21hWID59xzqxZ2nVeRQb9vrsYPJ5zQoMYIp0TKOTKqDwUX/N6fmS/Zar
          RfViPT9gRlATPSATGC6URq7VIf5Dockj/lPEvxrYrDrK3maXI67T30pNcx9vMaJRBBZqAOv5jUOB
          8FChH6bKOvMoPF9RrNcKRXdLDlJiG9g4UaCSLT+Qbsh+QJ8gRhVd4FB84XavXu0R0y8TubglpK9Y
          Ca81tGJUheNI3rzSkHp6pIQNo0LyUcDUrVNlXWz4Px8G8k/Ll6BKWcZ40egDuYVtLLrhX7atKz4l
          ecWLVtXjCYDqwSfC2Q7sRwrp0Mr82A==
          -----END CERTIFICATE-----
        private_key: |
          -----BEGIN PRIVATE KEY-----
          MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDWONVreTxnXt0w
          2FRDppKiygC3txMJ6gD+qfp1hz5sdFz8OQJMaLai4UlIzcDyzlEvtF2BtxFz+IB9
          5En5M/Vl+T5dQ8nX0uR7hwZLLii7CXmmDBxkZ2C/76bwZRTNVZDEhQf9hyBSmNK+
          hdnkKCvcuA/WyOCIerEw2doaqjj9ZYhobNHYVv4n+M3OrwvOL3UqLOEPBsKqn5fj
          Hzwh53ibpBxL9wMhPHaLnMA3lfHoAmToWLW4NTmVQ5dZ9WL3p8TuQk4+4RbpCyaQ
          ig5uAfepC3FBAoQql/cU0CWsQkOmty3nfRlxaVXBbWU4Foq+E08WFNdubpS7Mys4
          orfgnPYjAgMBAAECggEANI+dTdFhULul6eYqRq8IK4kExA7XTQdtVw69tTiJyHKE
          nh4ewkCvDyfXo1VYkjqtENdgWgNg9ON0I29v9wUYoPyWoKuRSrMj/GsU0D1zIPEi
          N+ugy8HRq0ZR34ntoLPt4UoCu+H7vEhi7PxKigCRQoam3DxNWy8/ao0JRqGdeg6M
          XinRJo5XXPyHNL1ZUEr7qTLLwgG5gf11KXdiunpKbscQAjSzApeiDeUfFpulSDNn
          LprUKr5cRc4SuBEdlnpVtItvxH7Xi5qLC+3ISRUmw40uMsluJzCspoJv8WsBh0lk
          rgfKJHO6KueTxzNJNGU2zj9P2YQnaWgmE5VU0JsWgQKBgQD4ATGEmNdC07TUtZlf
          BYq1h7uMbO1vVB3C0057jFyRrMtxktSg4xQRUmdq/UDm8+Ngj7WuiQ2+Sk7CnemC
          Jqu2yjbMDqjvHKmqvZsDrS37TVPjKKiQIEXQEZwiNH1K83RtuyxY4nuicxbTkSaK
          rAu2kQXt01H3HUu1wStZUhNBPQKBgQDdINQmA6V24dTYeQtDHCAZvbkVo6rYgCvg
          KNVl3zS59O+ckNAGK6Xmyor4EOVIiUCmkzEfCi288iWaTfGNJSxCYKbSrtcq8Ymf
          5F6LiRVz8OyCoglx3YH61JpPkdT46yBtRNNL9Ba7u9e8dzDy9QQbI6fHVP+P5oIW
          AyEjXaHK3wKBgD1FFjW7CNtisDco0kZOeTFV4jjUJGivsFaUm7wcNjZrKSva6ZsB
          3tBUumYNQT6NnGwbtPf0tid/9itQlgLoiN204YrSSFwiiaw8AZML8uM1/HaPce2B
          e53m69rretTMhsQhTNh8w6yjoE0OfCYgURh+had24LYbT7wMiCgeBdHFAoGALp+P
          W3yFVK2E7SeIYlv5wLOp5JAfo4pSte6mH9aSDWtBYid+VO67ChBGgMs/LK4TvYtn
          Xf4Nars7hm9MsM/Xpx8tzVoj7+ABfn7uGEmNBmcT1u9HQoTLtRFCf+hlmR4qNh++
          1VLfwDF46TnQTkmu1fIMnBCl2bdmUjHSuNwzEs0CgYEAzRlpGhizVek21kL0mhFO
          h2NkUhgcwAuVdCPuDNfBZ22lF6KpF0hluy11aMCBKzRuahQTmoXFlg2IIFDTZxnV
          39FfdQ2a64+DqgeQd/lAMr2XzJN83z0SpnZllRtNSFyFRx+0YNm1lR9OLy5iZ7U9
          Zopnz+RqMR8grLjK6NiKtaQ=
          -----END PRIVATE KEY-----
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

php:
  # Use ppa instead the default repository (only Debian family)
#  use_ppa: True
  # Set the ppa name (valid only if use_ppa is not none)
#  ppa_name: 'ondrej/php5'
  # Set the MongoDB driver version. You can specify (optionally) the driver version
  # when you add the php.mongo formula to your execution list
#  mongo_version: "1.5.5"
  ng:
    # this section contains mostly grain filtered data, while overrides
    # are possible in the pillar for unique cases, if your OS is not
    # represented, please consider adding it to the map.jinja for
    # upstream inclusion
    lookup:
#
#      # package definitions, these can be strings, lists of strings, or
#      # lists of dictionaries
#      pkgs:
#        memcached: php-pecl-memcached
#        # ensures both will be installed
#        curl: 
#          - php-common
#          - curl 
#        # a dictionary can be used in more complex cases where you want
#        # to pass forward special arguments to the pkg.installed call
#        # you MUST include the name argument for this to work
#        cli:
#           -
#             name: php-cli
#             fromrepo: my-specialrepo
#           -
#             name: php-common
#             skip_verify: True
#
#      # php-fpm os-specific settings
#      fpm:
#        conf: /location/of/php-fpm/config.conf
#        ini: /location/of/php-fpm/php.ini
#        pools: /location/of/php-fpm/pool.d
#        service: name-of-php5-fpm-service
#
#        # the default content of the php5-fpm main config file
#        defaults:
#          global:
#            pid: /var/run/php5-fpm.pid
#
#      # php-cli os-specific settings
#      cli:
#        ini: /location/of/php-cli/php.ini
#
#    # php-fpm settings
    fpm:
#
#      # settings for the php-fpm service
      service:
#        # if True, enables the php-fpm service, if False disables it
        enabled: True
#        # additional arguments passed forward to
#        # service.enabled/disabled
        opts:
          reload: True
#
#      # settings for the relevant php-fpm configuration files
#      config:
#
#        # options to manage the php.ini file used by php-fpm
#        ini:
#          # arguments passed through to file.managed
#          opts:
#            recurse: True
#          # php.ini file contents that will be merged with the
#          # defaults in php.ng.ini.defaults. See php.ng.ini.defaults for
#          # syntax guidelines.
#          settings:
#            PHP:
#              engine: 'Off'
#              extension_dir: '/usr/lib/php/modules/'
#              extension: [pdo_mysql.so, iconv.so, openssl.so]
#
#        # options to manage the php-fpm conf file
#        conf:
#          # arguments passed through to file.managed
#          opts:
#            recurse: True
#          # php-fpm conf file contents that will be merged with
#          # php.ng.lookup.fpm.defaults. See php.ng.ini.defaults for
#          # ini-style syntax guidelines.
#          settings:
#            global:
#              pid: /var/run/php-fpm/special-pid.file
#
#      # settings for fpm-pools
      pools:
#        # name of the pool file to be managed, this will be appended
#        # to the path specified in php.ng.lookup.fpm.pools
        'www.conf':
          enabled: False
        'vagrant.conf':
#          # If true, the pool file will be managed, if False it will be
#          # absent
          enabled: True
#          # arguments passed forward to file.managed or file.absent
#          opts:
#             replace: False
#
#          # pool file contents. See php.ng.ini.defaults for ini-style
#          # syntax guidelines.
          settings:
            vagrant:
              user: vagrant
              group: vagrant
              listen: /var/run/php-fpm/vagrant.sock
              listen.owner: vagrant
              listen.group: vagrant
              listen.mode: 0666
              pm: dynamic
              pm.max_children: 5
              pm.start_servers: 2
              pm.min_spare_servers: 1
              pm.max_spare_servers: 3
              'php_admin_value[memory_limit]': 300M
              catch_workers_output: 'yes'
    cli:
      ini:
        settings:
          PHP:
            engine: 'on'
            short_open_tag: 'off'
            asp_tags: 'off'
            precision: 14
            output_buffering: 4096
            zlib.output_compression: 'off'
            implicit_flush: 'off'
            serialize_precision: 17
            zend.enable_gc: 'On'
            expose_php: 'On'
            max_execution_time: 90
            max_input_time: 90
            max_input_vars: 3000
            memory_limit: 192M
            error_reporting: E_ALL & ~E_DEPRECATED & ~E_STRICT
            display_errors: 'Off'
            display_startup_errors: 'Off'
            log_errors: 'On'
            log_errors_max_len: 1024
            ignore_repeated_errors: 'Off'
            ignore_repeated_source: 'Off'
            report_memleaks: 'On'
            track_errors: 'Off'
            html_errors: 'On'
            variables_order: "GPCS"
            request_order: "GP"
            register_argc_argv: 'Off'
            auto_globals_jit: 'On'
            default_mimetype: "text/html"
            enable_dl: 'Off'
            file_uploads: 'On'
            upload_max_filesize: 200M
            post_max_size: 200M
            max_file_uploads: 20
            allow_url_fopen: 'On'
            allow_url_include: 'Off'
            default_socket_timeout: 60
            disable_functions: ''
            xdebug.remote_enable: 1
            xdebug.remote_connect_back: 1
            xdebug.remote_handler: "dbgp"
            sendmail_path: "/usr/local/bin/MailHog sendmail "

#
#    # php-xcache settings
#    xcache:
#      ini:
#        opts: {}
#        # contents of the xcache.ini file that are merged with defaults
#        # from php.xcache.ini.defaults. See php.ng.ini.defaults for ini-style
#        settings:
#          xcache:
#            xcache.size: 90M
#
#    # global php.ini settings
#    ini:
#      # Default php.ini contents. These follow a strict format. The top-
#      # level dict keys form ini group headings. Nested key/value
#      # pairs represent setting=value statements. If a value is a list,
#      # its contents will be joined by commas in final rendering.
#      defaults:
#        PHP:
#          engine: on
#          output_buffering: 4096
#          disable_functions:
#            - pcntl_alarm
#            - pcntl_fork
#            - pcntl_wait
#        'CLI Server':
#          cli_server_color: 'On'
