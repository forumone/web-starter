class f1site ($db_name = 'drupal', $db_user = 'drupal', $db_pass = 'drupal') {
  firewall { '100 allow http and https access':
    port   => [80, 443, 8080, 8081, 18983, 8983, 3306, 13306],
    proto  => tcp,
    action => accept,
  }

  yumrepo { "IUS":
    baseurl  => "http://dl.iuscommunity.org/pub/ius/stable/$operatingsystem/6/$architecture",
    descr    => "IUS Community repository",
    enabled  => 1,
    gpgcheck => 0
  }

  f1site::database { $db_name:
    username => $db_user,
    password => $db_pass
  }

  class { 'apache':
    default_vhost => false,
    mpm_module    => false,
  }

  class { 'apache::mod::prefork':
    startservers        => '8',
    minspareservers     => '5',
    maxspareservers     => '16',
    serverlimit         => '16',
    maxclients          => '16',
    maxrequestsperchild => '200',
  }

  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
  }

  php::module { ['xml', 'gd', 'pdo', 'mbstring', 'mysql']: notify => Service['httpd'] }

  class { 'php::mod_php5': }

  f1site::vhost { 'public': }

  class { 'f1site::solr': version => '4.4.0' }

  class { 'f1site::drush': }

  class { 'f1site::ruby': }

  file { "/home/vagrant/.bashrc":
    ensure  => present,
    owner   => "vagrant",
    group   => "vagrant",
    mode    => "644",
    content => template("f1site/bashrc.erb"),
  }

  class { 'f1site::node':
  }
}