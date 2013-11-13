class forumone::nodejs {
  case $::operatingsystem {
    /(?i:redhat|centos)/ : {
      package { 'npm': require => Class['epel'] }
    }
    /(?i:debian|ubuntu)/ : {
      package { 'npm': require => Anchor['apt::ppa::ppa:chris-lea/node.js-legacy'] }
    }
  }

  package { $::forumone::node_modules:
    ensure   => present,
    provider => 'npm',
    require  => Package['npm']
  }
}