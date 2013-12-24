define forumone::webserver::vhost ($path = undef, $allow_override = ['All'], $source = undef, $fastcgi_pass = '127.0.0.1:9000') {
  if $path {
    if $::forumone::webserver == 'apache' {
      apache::vhost { $name:
        port          => $::forumone::webserver_port,
        docroot       => $path,
        docroot_group => $host_gid,
        docroot_owner => $host_uid,
        directories   => [{
            path           => $path,
            allow_override => $allow_override
          }
          ]
      }
    } elsif $::forumone::webserver == 'nginx' {
      if empty($source) {
        nginx::file { "${name}.conf":
          content => template('forumone/webserver/nginx/vhost.erb'),
          notify  => Service['nginx']
        }
      } else {
        nginx::file { 'localhost':
          source => $source,
          notify => Service['nginx']
        }
      }
    }
  }
}