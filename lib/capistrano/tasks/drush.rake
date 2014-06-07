Rake::Task["deploy:check"].enhance ["drush:initialize"]
Rake::Task["deploy:publishing"].enhance ["drush:dbbackup"]
Rake::Task["deploy:published"].enhance do 
  Rake::Task["drush:run_updates"].invoke
end

namespace :load do
  task :defaults do
    set :drupal_features, true
    set :drupal_cmi, false
    set :drupal_features_path, %w[]
    set :drupal_updates, true
  end
end

namespace :drush do
  desc "Initializes drush directory and aliases"
  task :initialize do
    invoke 'drush:drushdir'
    invoke 'drush:aliases'
  end

  desc "Creates ~/.drush directory if it's missing"
  task :drushdir do
    on roles(:all) do
      home = capture(:echo, '$HOME') 
      unless test "[ -d #{home}/.drush ]"
        execute :mkdir, "#{home}/.drush"
      end
    end
  end

  desc "Copies any aliases from the root checkout to the logged in user's ~/.drush directory"
  task :aliases do
    on roles(:all) do
      within "#{release_path}" do
        home = capture(:echo, '$HOME')
        execute :cp, "*.aliases.drushrc.php", "#{home}/.drush", "|| :"
      end
    end
  end

  desc "Triggers drush sql-sync to copy databases between environments"
  task :sqlsync do 
    on roles(:app) do
      if ENV['source']
        within "#{release_path}/public" do
          execute :drush, "-p -r #{current_path}/public -l #{fetch(:site_url)[0]} sql-sync #{ENV['source']} @self -y"
        end
      end
    end

    invoke 'drush:run_updates'
  end

  desc "Triggers drush rsync to copy files between environments"
  task :rsync do
    on roles(:app) do
      if ENV['path']
        path = ENV['path']
      else
        path = '%files'
      end

      if ENV['source']
        within "#{release_path}/public" do
          execute :drush, "-y -p -r #{current_path}/public -l #{fetch(:site_url)[0]} rsync #{ENV['source']}:#{path} @self:#{path} --mode=rz"
        end
      end
    end
  end

  desc "Creates database backup"
  task :dbbackup do 
    on roles(:app) do
      unless test " [ -f #{release_path}/db.sql ]"
        within "#{release_path}/public" do
          execute :drush, "-r #{current_path}/public -l #{fetch(:site_url)[0]} sql-dump -y >> #{release_path}/db.sql"
        end
      end
    end
  end
  
  desc "Runs all pending update hooks"
  task :updatedb do
    on roles(:app) do
      within "#{release_path}/public" do
        fetch(:site_url).each do |site|
          execute :drush, "-y -p -r #{current_path}/public -l #{site}", 'updatedb'
        end
      end
    end
  end

  desc "Clears the Drupal cache"
  task :cache_clear do
    on roles(:app) do
      within "#{release_path}/public" do
        fetch(:site_url).each do |site|
          execute :drush, "-y -p -r #{current_path}/public -l #{site}", 'cc all'
        end
      end
    end
  end

  desc "Runs pending updates"
  task :run_updates do
    # Run all pending database updates
    if fetch(:drupal_updates)
      invoke 'drush:updatedb'
    end
    
    invoke 'drush:cache_clear'
	
	# If we're using Features revert Features
	if fetch(:drupal_features)
      invoke 'drush:features:revert'
      invoke 'drush:cache_clear'
    end
    
    # If we're using Drupal Configuration Management module synchronize the Configuration
    if fetch(:drupal_cmi)
      invoke 'drush:configuration:sync'
      invoke 'drush:cache_clear'
    end
  end
  
  namespace :configuration do
    desc "Load Configuration from the Data Store and apply it to the Active Store"
    task :sync do
      on roles(:app) do
        within "#{release_path}/public" do
          execute :drush, "-y -p -r #{current_path}/public -l #{fetch(:site_url)}", 'config-sync'
        end
      end
    end
  end
  
  namespace :features do
    desc "Revert Features"
    task :revert do
      on roles(:app) do
        within "#{release_path}/public" do
          # For each site
          fetch(:site_url).each do |site|
            # If we've explictly set a Features path array
            if fetch(:drupal_features_path).length
              # Iterate through each element
              fetch(:drupal_features_path).each do |path|
                features_path = "#{current_path}/public/#{path}"
                # Get a list of all Feature modules in that path
                features = capture(:ls, '-x', features_path).split
                features.map do |feature|
                  # Make sure the Feature is actually enabled, otherwise it will fail
                  feature_name = capture(:drush, "pm-list --pipe --type=module --status=enabled --no-core | grep '^#{feature}$' || :")
                  if !feature_name.empty?
                    execute :drush, "-y -p -r #{current_path}/public -l #{site}", 'fr', feature
                  end
                end
              end
            else
              execute :drush, "-y -p -r #{current_path}/public -l #{site}", 'fra'
            end
          end
        end
      end
    end
  end
end
