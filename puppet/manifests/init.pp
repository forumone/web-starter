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
    webserver => 'apache'
  }

  forumone::solr::collection { "drupal": }

  forumone::webserver::vhost { "vagrant": path => "/vagrant/public" }

  forumone::database { "drupal": }

  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
  }
}