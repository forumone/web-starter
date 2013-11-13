class f1site::node {
  case $::operatingsystem {
    /(?i:redhat|centos)/ : {
      package { 'npm': require => Class['epel'] }
    }
    /(?i:debian|ubuntu)/ : {
      package { 'npm': require => anchor['apt::ppa::ppa:chris-lea/node.js-legacy'] }
    }
  }

  package { 'grunt-cli':
    ensure   => present,
    provider => 'npm',
    require  => Package['npm']
  }
}