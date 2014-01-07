class forumone (
  $ports                 = $forumone::params::ports,
  $percona_install       = $forumone::params::percona_install,
  $percona_manage_repo   = $forumone::params::percona_manage_repo,
  $percona_version       = $forumone::params::percona_version,
  $webserver             = $forumone::params::webserver,
  $webserver_port        = $forumone::params::webserver_port,
  $php_modules           = $forumone::params::php_modules,
  $php_fpm_listen        = $forumone::params::php_fpm_listen,
  $nginx_conf            = $forumone::params::nginx_conf,
  $node_install          = $forumone::params::node_install,
  $node_modules          = $forumone::params::node_modules,
  $ruby_install          = $forumone::params::ruby_install,
  $ruby_version          = $forumone::params::ruby_version,
  $ruby_user             = $forumone::params::ruby_user,
  $ruby_group            = $forumone::params::ruby_group,
  $drush_install         = $forumone::params::drush_install,
  $solr_install          = $forumone::params::solr_install,
  $solr_version          = $forumone::params::solr_version,
  $varnish_install       = $forumone::params::varnish_install,
  $varnish_backend_port  = $forumone::params::varnish_backend_port,
  $varnish_bind          = $forumone::params::varnish_bind,
  $varnish_cache_size    = $forumone::params::varnish_cache_size,
  $memcached_install     = $forumone::params::memcached_install,
  $memcached_port        = $forumone::params::memcached_port,
  $memcached_maxconn     = $forumone::params::memcached_maxconn,
  $memcached_cachesize   = $forumone::params::memcached_cachesize,
  $mailcatcher_install   = $forumone::params::mailcatcher_install,
  $mailcatcher_smtp_ip   = $forumone::params::mailcatcher_smtp_ip,
  $mailcatcher_smtp_port = $forumone::params::mailcatcher_smtp_port,
  $mailcatcher_http_ip   = $forumone::params::mailcatcher_http_ip,
  $mailcatcher_http_port = $forumone::params::mailcatcher_http_port,
  $mailcatcher_path      = $forumone::params::mailcatcher_path) inherits forumone::params {
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
    enable  => true,
    require => Package["php-fpm"]
  }

  file { '/etc/php-fpm.d/www.conf':
    ensure  => present,
    owner   => "root",
    group   => "root",
    content => template("forumone/fpm_pool.erb"),
    notify  => Service["php-fpm"],
    require => Package["php-fpm"]
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

  file { "/home/vagrant/.ssh/config":
    ensure  => present,
    content => template("forumone/ssh_config.erb"),
    owner   => "vagrant",
    mode    => 600
  }

  if $mailcatcher_install == true {
    class { 'forumone::mailcatcher': }
  }

  if $percona_install == true {
    file { '/etc/mysql': ensure => 'directory', }

    file { '/etc/mysql/conf.d': ensure => 'directory', }

    class { 'percona':
      server             => true,
      percona_version    => $percona_version,
      manage_repo        => $percona_manage_repo,
      config_include_dir => '/etc/mysql/conf.d',
      configuration      => {
        'mysqld/log_bin' => 'absent'
      }
    }
  }
}