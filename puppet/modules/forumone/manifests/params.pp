class forumone::params (
  $ports         = [80, 443, 8080, 8081, 18983, 8983, 3306, 13306],
  # Percona configuration
  $percona_manage_repo        = true,
  $percona_version            = "5.5",
  $webserver     = "nginx",
  $webserver_port = 80,
  # Apache configuration
  $apache_startservers        = 8,
  $apache_minspareservers     = 5,
  $apache_maxspareservers     = 16,
  $apache_serverlimit         = 16,
  $apache_maxclients          = 16,
  $apache_maxrequestsperchild = 200,
  # nginx conf
  $nginx_conf    = ['client_max_body_size 200m', 'client_body_buffer_size 2m'],
  $nginx_worker_processes     = 1,
  # PHP configuration
  $php_modules   = ['xml', 'gd', 'pdo', 'mbstring', 'mysql'],
  $drush_install = true,
  # Node configuration
  $node_install  = true,
  $node_modules  = ["grunt-cli"],
  # Ruby configuration
  $ruby_install  = true,
  $ruby_version  = "1.9.3-p448",
  $ruby_user     = "vagrant",
  $ruby_group    = "vagrant",
  $solr_install  = true,
  $solr_version  = "3.6.2") {
}