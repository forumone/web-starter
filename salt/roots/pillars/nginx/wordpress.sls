nginx:
  ng:
    vhosts:
      managed:
        vagrant.conf:
          enabled: True
          config:
            - server:
              - server_name: localhost
              - listen:
                - 8080
                - default_server
              - listen:
                - 443 ssl default_server
              - index: index.php index.html
              - ssl_certificate: ssl/vagrant.crt
              - ssl_certificate_key: ssl/vagrant.key
              - root: {{ document_root }}
              - port_in_redirect: 'off'
              - access_log: /var/log/nginx/vagrant.log
              - location /:
                - try_files: $uri $uri/ @rewrite
              - location @rewrite:
                - rewrite: ^/(.*)$ /index.php?q=$uri&$args
              - location ~ \.php$:
                - fastcgi_split_path_info: ^(.+\.php)(/.+)$
                - include: fastcgi_params
                - fastcgi_param: SCRIPT_FILENAME $document_root$fastcgi_script_name
                - fastcgi_intercept_errors: 'on'
                - fastcgi_pass: unix:/var/run/php-fpm/vagrant.sock
