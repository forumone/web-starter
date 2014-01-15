$platform = 'drupal'
$host = 'f1dev'

case $::operatingsystem {
  /(?i:redhat|centos)/ : {
    Yumrepo <| |> -> Package <| provider != 'rpm' |>
  }
  /(?i:debian|ubuntu)/ : {
    exec { "apt-update": command => "/usr/bin/apt-get update" }
    Exec["apt-update"] -> Package <| |>
  }
}

hiera_include('classes')
