define forumone::database ($username = 'drupal', $password = 'drupal') {
  file { '/etc/mysql': ensure => 'directory', }

  file { '/etc/mysql/conf.d': ensure => 'directory', }

  class { 'percona':
    server             => true,
    percona_version    => $::forumone::percona_version,
    manage_repo        => $::forumone::percona_manage_repo,
    config_include_dir => '/etc/mysql/conf.d'
  }
  
  percona::database { $name:
    ensure  => present,
    require => Service['mysql']
  }

  percona::rights { "${username}@localhost/${name}":
    priv     => 'all',
    user     => $username,
    database => $name,
    password => $password,
    host     => 'localhost'
  }

  percona::rights { "${username}@10.%/${name}":
    priv     => 'all',
    user     => $username,
    database => $name,
    password => $password,
    host     => '10.%'
  }
}