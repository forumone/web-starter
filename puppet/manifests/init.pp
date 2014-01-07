node default {
  case $::operatingsystem {
    /(?i:redhat|centos)/ : {
      Yumrepo <| |> -> Package <| provider != 'rpm' |>
    }
    /(?i:debian|ubuntu)/ : {
      exec { "apt-update": command => "/usr/bin/apt-get update" }
      Exec["apt-update"] -> Package <| |>
    }
  }

  class { "forumone":
    webserver => 'nginx',
    memcached_cachesize => 8192
  }

  forumone::solr::collection { "drupal": }

  forumone::webserver::vhost { "vagrant": path => "/vagrant/public" }

  forumone::database { "drupal": }

  php::ini { '/etc/php.ini':
    display_errors      => 'On',
    memory_limit        => '256M',
    upload_max_filesize => '50M',
    post_max_size       => '100M',
    sendmail_path       => "/usr/bin/env catchmail",
    notify              => [ Service['php-fpm'] ]
  }

  php::module::ini { 'xcache': 
    settings => {
      'xcache.size' => '96M'
    }
  }
  
  php::module::ini { 'xdebug':
    pkgname => 'pecl-xdebug',
    zend => '/usr/lib64/php/modules',
    settings => {
      'xdebug.remote_enable' => 1,
      'xdebug.remote_connect_back' => 1,
      'xdebug.remote_handler' => 'dbgp'
    }
  }

  percona::conf {
    'innodb_file_per_table':
      content => "[mysqld]\ninnodb_file_per_table";

    'query_cache_size':
      content => "[mysqld]\nquery_cache_size = 128M";

    'table_open_cache':
      content => "[mysqld]\ntable_open_cache = 2048";

    'table_cache':
      content => "[mysqld]\ntable_cache = 1024";

    'memory_buffers':
      content => "[mysqld]\ntmp_table_size = 128\nmax_heap_table_size = 128M\njoin_buffer_size = 1M\nmyisam_sort_buffer_size = 8M\nsort_buffer_size = 2M"
    ;

    'thread_cache':
      content => "[mysqld]\nthread_cache_size = 4";

    'max_allowed_packets':
      content => "[mysqld]\nmax_allowed_packet=100M";
  }
}
