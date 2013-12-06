class forumone::memcached () {
  class { "::memcached":
    port      => $::forumone::memcached_port,
    maxconn   => $::forumone::memcached_maxconn,
    cachesize => $::forumone::memcached_cachesize
  }
}