set :application, 'ucar_globalchange'
set :repo_url, 'git@github.com:forumone/ucar-globalchange.git'

set :scm, :git
set :deploy_via, :remote_cache

set :format, :pretty
set :log_level, :debug
set :user_sudo, false
set :pty, true

set :linked_dirs, %w{public/sites/default/files}

set :keep_releases, 3

after "deploy:symlink:release", "deploy:symlink:drupal"
after "deploy:symlink:drupal", "deploy:symlink:settings"
after "deploy:symlink:settings", "drush:dbbackup"
after "drush:dbbackup", "drush:run_updates"
after "deploy:revert_release", "deploy:revert_database"
