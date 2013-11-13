define f1site::database(
	$username		= 'drupal',
	$password		= 'drupal',
  $version    = '5.5'
) {
  
  file { '/etc/mysql':
  	ensure			=> 'directory',
  }
  
  file { '/etc/mysql/conf.d':
  	ensure			=> 'directory',
  }
  
  class { 'percona':
    server          => true,
    percona_version => $version,
    manage_repo     => true,
    config_include_dir => '/etc/mysql/conf.d'
  }
  
  percona::database { $name:
  	ensure          => present,
  }
  
  percona::rights {"${username}@localhost/${name}":
    priv            => 'all',
    user			=> $username,
    database		=> $name,
    password        => $password
  }
}
