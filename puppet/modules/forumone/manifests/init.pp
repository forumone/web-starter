class forumone (
  $ports                = $forumone::params::ports,
  $percona_manage_repo  = $forumone::params::percona_manage_repo,
  $percona_version      = $forumone::params::percona_version,
  $webserver            = $forumone::params::webserver,
  $webserver_port       = $forumone::params::webserver_port,
  $php_modules          = $forumone::params::php_modules,
  $nginx_conf           = $forumone::params::nginx_conf,
  $node_install         = $forumone::params::node_install,
  $node_modules         = $forumone::params::node_modules,
  $ruby_install         = $forumone::params::ruby_install,
  $ruby_version         = $forumone::params::ruby_version,
  $ruby_user            = $forumone::params::ruby_user,
  $ruby_group           = $forumone::params::ruby_group,
  $drush_install        = $forumone::params::drush_install,
  $solr_install         = $forumone::params::solr_install,
  $solr_version         = $forumone::params::solr_version,
  $varnish_install      = $forumone::params::varnish_install,
  $varnish_backend_port = $forumone::params::varnish_backend_port,
  $varnish_bind         = $forumone::params::varnish_bind,
  $varnish_cache_size   = $forumone::params::varnish_cache_size,
  $memcached_install    = $forumone::params::memcached_install,
  $memcached_port       = $forumone::params::memcached_port,
  $memcached_maxconn    = $forumone::params::memcached_maxconn,
  $memcached_cachesize  = $forumone::params::memcached_cachesize) inherits forumone::params {
  case $::operatingsystem {
    /(?i:redhat|centos)/ : {
      class { 'forumone::os::fedora::project': }
    }
  }

  if $webserver == 'apache' {
    $service = "httpd"

    class { "forumone::webserver::apache": }
  } elsif $webserver == 'nginx' {
    $service = "nginx"

    class { "forumone::webserver::nginx": }
  }

  package { 'php-fpm': ensure => present }

  service { 'php-fpm':
    ensure  => running,
    require => Package['php-fpm']
  }

  php::module { $php_modules: notify => Service[$service, 'php-fpm'] }

  if $node_install == true {
    class { "forumone::nodejs": }
  }

  if $ruby_install == true {
    class { "forumone::ruby": }
  }

  if $drush_install == true {
    class { "forumone::drush": }
  }

  if $varnish_install == true {
    class { "forumone::varnish": }
  }

  if $solr_install == true {
    class { "forumone::solr": }
  }

  if $memcached_install == true {
    class { "forumone::memcached": }
  }
  
  file { "/home/vagrant/.bashrc":
    ensure  => present,
    owner   => "vagrant",
    group   => "vagrant",
    mode    => "644",
    content => template("forumone/bashrc.erb"),
  }
  
  file { "/home/vagrant/.ssh/config" :
    ensure  => present,
    content => template("forumone/ssh_config.erb"),
    owner   => "vagrant",
    mode    => 600
  }
}