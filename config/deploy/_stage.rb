# The stage to use
set :stage, :{{name}}

# An array containing site URL, used for Varnish bans
set :site_url, %w[{{site_url}}]

# An array containing drupal sites to copy settings files in
set :site_folder, %w[{{site_folder}}]

# The directory where the webroot 
set :webroot, '{{webroot}}'

# The path to the project on the server
set :deploy_to, '{{deploy_to}}'

# Where the temporary directory is
set :tmp_dir, fetch(:deploy_to)

# Which branch to deploy
set :branch, '{{branch}}'

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w[{{role_app}}], :primary => true
role :web, %w[{{role_web}}]
role :db,  %w[{{role_db}}]
