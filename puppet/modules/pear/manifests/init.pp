define pear(
  $package, 
  $creates, 
  $channel=""
) {

  # Install the PEAR package.
  if ! defined(Package['php-pear']) {
    package { 'php-pear':
      ensure => present,
    }
  }
  
  if $channel != "" and !defined(Exec["pear channel-discover ${channel}"]) {
    $requires = [ Package['php-pear'], Exec["pear channel-discover ${channel}"]]
    exec { "pear channel-discover ${channel}":
      # We can't execute channel-discover successfully if it exists already.
      command => "pear channel-info ${channel} || pear channel-discover ${channel}",
      creates => "/usr/share/php/.channels/${channel}.reg",
      require => Package['php-pear'],
      path => ["/usr/bin", "/usr/sbin"],
    }
  }
  
  exec { "${package}-install":
    # Don't install it if it's already there.
    command => "pear info ${package} || pear install ${package}",
    require => $requires,
    creates => $creates,
    path => ["/usr/bin", "/usr/sbin"],
  }
}

