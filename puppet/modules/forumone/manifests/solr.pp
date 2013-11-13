class forumone::solr () {
  $version_array = split($::forumone::solr_version, '[.]')
  $major_version = $version_array[0]
  $conf = "${major_version}.x"

  if $major_version == "4" {
    $filename = "solr-${::forumone::solr_version}"
    $path = "/opt/${filename}/example"
  } else {
    $filename = "apache-solr-${::forumone::solr_version}"
    $path = "/opt/${filename}/example/multicore"
  }

  $url = "http://archive.apache.org/dist/lucene/solr/${::forumone::solr_version}/${filename}.tgz"

  # install the java package.
  package { ["java-1.7.0-openjdk"]: ensure => installed, }

  # Download apache solr
  exec { "forumone::solr::download":
    command => "wget --directory-prefix=/opt ${url}",
    path    => '/usr/bin',
    require => Package["java-1.7.0-openjdk"],
    creates => "/opt/${filename}.tgz",
    timeout => 4800,
  }

  # extract from the solr archive
  exec { "forumone::solr::extract":
    command => "tar -zxvf /opt/${filename}.tgz -C /opt",
    path    => ["/bin"],
    require => [Exec["forumone::solr::download"]],
    creates => "/opt/${filename}/LICENSE.txt",
  }

  file { "/etc/default/jetty":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("forumone/solr/etc_default.erb"),
    require => Exec["forumone::solr::extract"],
  }

  file { "/etc/init.d/solr":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "755",
    content => template("forumone/solr/solr.erb"),
    require => Exec["forumone::solr::extract"],
  }

  service { 'solr':
    ensure    => running,
    require   => [Package["java-1.7.0-openjdk"], File["/etc/init.d/solr"]],
    pattern   => 'start.jar',
    hasstatus => false
  }

  file { '/var/log/solr':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

  concat { "${path}/solr.xml":
    owner => "root",
    group => "root",
    mode  => 644,
    notify  => Service['solr']
  }

  concat::fragment { "solr_header":
    target  => "${path}/solr.xml",
    content => "<solr persistent='false'><cores adminPath='/admin/cores'>",
    order   => 01
  }
  
  concat::fragment { "solr_footer":
    target  => "${path}/solr.xml",
    content => "</cores></solr>",
    order   => 999
  }
}
