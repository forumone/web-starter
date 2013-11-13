class f1site::solr(
  $version      = '3.6.2'
) {

  $version_array = split($version, '[.]')
  $major_version = $version_array[0]
  $conf = "${major_version}.x"
  
  #install the java package.
  package { ["java-1.7.0-openjdk"]:
    ensure  => installed,
  }
  
  #Download apache solr
  exec{"f1site::solr::download":
    command => "wget --directory-prefix=/opt http://archive.apache.org/dist/lucene/solr/${version}/solr-${version}.tgz",
    path => '/usr/bin',
    require => Package ["java-1.7.0-openjdk"],
    creates => "/opt/solr-${version}.tgz",
    timeout     => 4800,
  }
  
  #extract from the solr archive 
  exec { "f1site::solr::extract":
    command => "tar -zxvf /opt/solr-${version}.tgz -C /opt",
    path => ["/bin"],
    require => [ Exec["f1site::solr::download"] ], 
    creates => "/opt/solr-${version}/LICENSE.txt", 
  }
  
  file { "/etc/default/jetty":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("f1site/solr/etc_default.erb"),
    require => Exec ["f1site::solr::extract"],
  }
  
  file { "/etc/init.d/solr":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "755",
    content => template("f1site/solr/solr.erb"),
    require => Exec ["f1site::solr::extract"],
  }
  
  service { 'solr':
    ensure     => running,
    require => [ Package ["java-1.7.0-openjdk"], File ["/etc/init.d/solr"] ],
    pattern => 'start.jar',
    hasstatus => false
  } 
  
  file { '/var/log/solr': 
    ensure    => 'directory',
    owner     => 'root',
    group     => 'root',
  }
  
  if $major_version == '4' {
	  file { "/opt/solr-${version}/example/solr/collection1/conf/elevate.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/elevate.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/protwords.txt":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/protwords.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/mapping-ISOLatin1Accent.txt":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/mapping-ISOLatin1Accent.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/schema_extra_fields.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/schema_extra_fields.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/schema_extra_types.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/schema_extra_types.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/schema.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/schema.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/solrconfig_extra.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/solrconfig_extra.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/solrconfig.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/solrconfig.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/solr-${version}/example/solr/collection1/conf/solrcore.properties":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("f1site/solr/conf/$conf/solrcore_properties.erb"),
	    require => Exec ["f1site::solr::extract"],
	    notify  => Service['solr']
	  }
	}
	elsif $major_version == '3' {
	  file { "/opt/apache-solr-${version}/example/solr/conf/protwords.txt":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("acquia/solr/conf/3.x/protwords.erb"),
	    require => Exec ["acquia::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/apache-solr-${version}/example/solr/conf/schema_extra_fields.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("acquia/solr/conf/3.x/schema_extra_fields.erb"),
	    require => Exec ["acquia::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/apache-solr-${version}/example/solr/conf/schema_extra_types.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("acquia/solr/conf/3.x/schema_extra_types.erb"),
	    require => Exec ["acquia::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/apache-solr-${version}/example/solr/conf/schema.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("acquia/solr/conf/3.x/schema.erb"),
	    require => Exec ["acquia::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/apache-solr-${version}/example/solr/conf/solrconfig_extra.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("acquia/solr/conf/3.x/solrconfig_extra.erb"),
	    require => Exec ["acquia::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/apache-solr-${version}/example/solr/conf/solrconfig.xml":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("acquia/solr/conf/3.x/solrconfig.erb"),
	    require => Exec ["acquia::solr::extract"],
	    notify  => Service['solr']
	  }
	  
	  file { "/opt/apache-solr-${version}/example/solr/conf/solrcore.properties":
	    ensure  => present,
	    owner   => "root",
	    group   => "root",
	    mode    => "644",
	    content => template("acquia/solr/conf/3.x/solrcore_properties.erb"),
	    require => Exec ["acquia::solr::extract"],
	    notify  => Service['solr']
	  }
	}
}
