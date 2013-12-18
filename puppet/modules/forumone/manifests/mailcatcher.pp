class forumone::mailcatcher () {
  case $::osfamily {
    'Debian' : { $packages = ['ruby-dev', 'sqlite3', 'libsqlite3-dev', 'rubygems'] }
    'Redhat' : { $packages = ['ruby-devel', 'sqlite', 'sqlite-devel', 'rubygems'] }
    default  : { fail("${::osfamily} is not supported.") }
  }

  file { '/var/log/mailcatcher':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  $options = sort(join_keys_to_values({
    ' --smtp-ip'   => $forumone::mailcatcher_smtp_ip,
    ' --smtp-port' => $forumone::mailcatcher_smtp_port,
    ' --http-ip'   => $forumone::mailcatcher_http_ip,
    ' --http-port' => $forumone::mailcatcher_http_port,
  }
  , ' '))

  package { $packages: ensure => 'present' } ->
  package { 'tilt':
    ensure   => '1.4.1',
    provider => 'gem'
  } ->
  package { 'mailcatcher':
    ensure   => 'present',
    provider => 'gem'
  }

  file { "/etc/default/mailcatcher":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("forumone/mailcatcher/etc_default.erb"),
  }

  file { "/etc/init.d/mailcatcher":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "755",
    content => template("forumone/mailcatcher/mailcatcher.erb"),
    require => Package["mailcatcher"]
  }

  service { 'mailcatcher':
    ensure  => running,
    hasstatus => false,
    enable => true,
    require => File["/etc/init.d/mailcatcher"]
  }
}
