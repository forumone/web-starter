class forumone::varnish () {
  case $::operatingsystem {
    /(?i:redhat|centos)/ : {
      yumrepo { "varnish":
        baseurl  => "http://repo.varnish-cache.org/redhat/varnish-3.0/el6/$architecture/",
        descr    => "Varnish",
        enabled  => 1,
        priority => 1,
        gpgcheck => 0
      }
    }
  }

  service { "varnish":
    ensure => running,
    enable  => true,
    hasrestart => true,
    hasstatus => true,
    status => '/usr/sbin/service  varnish status | grep "is running"',
    require => Package["varnish"],
  }

  package { "varnish":
    ensure  => installed,
    require => Yumrepo["varnish"]
  }

  exec { "varnish-restart":
    command     => "/etc/init.d/varnish restart",
    refreshonly => true,
    require     => Package["varnish"],
  }

  file { "/etc/sysconfig/varnish":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("forumone/varnish/etc_default.erb"),
    require => Package["varnish"],
    notify  => Service["varnish"],
  }

  file { "/etc/varnish/default.vcl":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("forumone/varnish/default.erb"),
    require => Package["varnish"],
    notify  => Service["varnish"],
  }

  file { "/etc/varnish/acl.vcl":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("forumone/varnish/acl.erb"),
    require => Package["varnish"],
    notify  => Service["varnish"],
  }

  file { "/etc/varnish/backends.vcl":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("forumone/varnish/backends.erb"),
    require => Package["varnish"],
    notify  => Service["varnish"],
  }
}
