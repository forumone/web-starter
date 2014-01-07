define forumone::database ($username = 'drupal', $password = 'drupal') {
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

  percona::rights { "${username}@%/${name}":
    priv     => 'all',
    user     => $username,
    database => $name,
    password => $password,
    host     => '%'
  }
}
