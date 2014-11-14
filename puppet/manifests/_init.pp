$platform = '{{platform}}'
$host = '{{host}}'

case $::operatingsystem {
  /(?i:redhat|centos)/ : {
    Yumrepo <| |> -> Package <| provider != 'rpm' |>
  }
  /(?i:debian|ubuntu)/ : {
    exec { "apt-update": command => "/usr/bin/apt-get update" }
    Exec["apt-update"] -> Package <| |>
  }
}

class php::params {
  $php_package_name = $::forumone::php::prefix
  $php_apc_package_name = "${::forumone::php::prefix}-pecl-apc"
  $common_package_name = "${::forumone::php::prefix}-common"
  $cli_package_name = "${::forumone::php::prefix}-cli"
  $php_conf_dir = '/etc/php.d'
  $fpm_package_name = "${::forumone::php::prefix}-fpm"
  $fpm_service_name = 'php-fpm'
  $fpm_pool_dir = '/etc/php-fpm.d'
  $fpm_conf_dir = '/etc'
  $fpm_error_log = '/var/log/php-fpm/error.log'
  $fpm_pid = '/var/run/php-fpm/php-fpm.pid'
  $httpd_package_name = 'httpd'
  $httpd_service_name = 'httpd'
  $httpd_conf_dir = '/etc/httpd/conf.d'
}

hiera_include('classes')
