set :application, 'MCC'
set :repo_url, 'git@code.forumone.com:mcc/mcc-redesign.git'

set :scm, :git
set :deploy_via, :remote_cache

set :format, :pretty
set :log_level, :info
set :pty, true

set :linked_dirs, %w{public/sites/default/files}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

#after "deploy:symlink:release", "deploy:symlink:drupal"
#after "deploy:symlink:drupal", "deploy:symlink:settings"
#after "deploy", "drush:updatedb"
#after "drush:updatedb", "drush:cache"
#after "drush:cache", "drush:features:revert"
