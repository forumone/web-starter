class forumone::webserver::apache {
  require forumone::params

  class { '::apache':
    default_vhost => false,
    mpm_module    => false,
  }

  class { 'apache::mod::prefork':
    startservers        => $::forumone::apache_startservers,
    minspareservers     => $::forumone::apache_minspareservers,
    maxspareservers     => $::forumone::apache_maxspareservers,
    serverlimit         => $::forumone::apache_serverlimit,
    maxclients          => $::forumone::apache_maxclients,
    maxrequestsperchild => $::forumone::apache_maxrequestsperchild,
  }

  class { 'php::mod_php5':
  }

}