class forumone::webserver::nginx () {
  class { '::nginx': http_raw_lines => $::forumone::nginx_conf }
}