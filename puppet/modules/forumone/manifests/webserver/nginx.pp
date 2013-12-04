class forumone::webserver::nginx() {
  class { '::nginx': } 
  
  package { 'php-fpm': }
}