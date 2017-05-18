nginx:
  ng:
    vhosts:
      managed:
        vagrant.conf:
          enabled: True
          config:
            - server:
              - server_name: localhost
              - listen: 8080 default_server
              - listen: 443 ssl default_server
              - index: index.php index.html
              - ssl_certificate: ssl/vagrant.crt
              - ssl_certificate_key: ssl/vagrant.key
              - root: {{ document_root }}
              - access_log: /var/log/nginx/vagrant.log
              - location /:
                - try_files: $uri $uri/ @rewrite
              - location @rewrite:
                - rewrite: ^/(.*)$ /index.php?q=$1
              - location ~ \.php$:
                - fastcgi_split_path_info: ^(.+\.php)(/.+)$
                - fastcgi_param: PATH_INFO $fastcgi_path_info
                - fastcgi_param: SCRIPT_FILENAME $document_root$fastcgi_script_name
                - include: fastcgi_params
                - fastcgi_intercept_errors: 'on'
                - fastcgi_pass: unix:/var/run/php-fpm/vagrant.sock
              - location ~ ^/sites/.*/files/(imagecache|styles)/:
                - try_files: $uri @rewrite
