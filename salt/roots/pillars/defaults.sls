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
      innodb-log-file-size: 10M
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
        user: vagrant
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
