define forumone::webserver::vhost ($path = undef, $allow_override = ['All'], $source = undef, $fastcgi_pass = '127.0.0.1:9000') {
  if $path {
    if $::forumone::webserver == 'apache' {
      apache::vhost { $name:
        port        => '80',
        docroot     => $path,
        directories => [{
            path           => $path,
            allow_override => $allow_override
          }
          ]
      }
    } elsif $::forumone::webserver == 'nginx' {
      if empty($source) {
        nginx::file { "${name}.conf": content => template('forumone/webserver/nginx/vhost.erb') }
      } else {
        nginx::file { 'localhost': source => $source }
      }
    }
  }
}