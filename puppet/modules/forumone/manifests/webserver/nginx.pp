class forumone::webserver::nginx () {
  class { '::nginx':
    http_raw_lines   => $::forumone::nginx_conf,
    worker_processes => $::forumone::nginx_worker_processes
  }
}