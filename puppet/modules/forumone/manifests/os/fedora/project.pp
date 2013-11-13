class forumone::os::fedora::project () {
  firewall { '100 allow http and https access':
    port   => $forumone::params::ports,
    proto  => tcp,
    action => accept,
  }

  yumrepo { "IUS":
    baseurl  => "http://dl.iuscommunity.org/pub/ius/stable/$operatingsystem/6/$architecture",
    descr    => "IUS Community repository",
    enabled  => 1,
    gpgcheck => 0
  }

  class { "epel":
  }
}