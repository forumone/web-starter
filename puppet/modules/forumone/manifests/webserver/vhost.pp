define forumone::webserver::vhost ($path = undef, $allow_override = ['All']) {
  if $path {
    if $::forumone::webserver == 'apache' {
      apache::vhost { 'localhost':
        port        => '80',
        docroot     => $path,
        directories => [{
            path           => $path,
            allow_override => $allow_override
          }
          ]
      }
    } elsif $::forumone::webserver == 'nginx' {
    }

  }
}