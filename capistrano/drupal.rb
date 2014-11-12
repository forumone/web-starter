# Revert the database when a rollback occurs
Rake::Task["deploy:rollback_release_path"].enhance do
  invoke "drupal:revert_database"
end

# Backup the database when publishing a new release
Rake::Task["deploy:publishing"].enhance ["drupal:dbbackup"]

# Copy drush aliases when we check compatibility
Rake::Task["deploy:check"].enhance ["drush:initialize"]

# After publication run updates
Rake::Task["deploy:published"].enhance do 
  Rake::Task["drush:update"].invoke
end

namespace :drupal do
  desc "Install Drupal"
  task :install do
    invoke 'drush:siteinstall'
  end
  
  desc "Copy Drupal and web server configuration files"
  task :settings do
    on roles(:app) do
      fetch(:site_folder).each do |folder|
        if test " [ -e #{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.php ]"
          execute :rm, "-f", "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.php"
        end
        execute :ln, '-s', "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.#{fetch(:stage)}.php", "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.php"
      end
        
      # If a .htaccess file for the stage exists
      if test " [ -f #{current_path}/#{fetch(:webroot, 'public')}/htaccess.#{fetch(:stage)} ]"
        # If there is currently an .htaccess file
        if test " [ -f #{current_path}/#{fetch(:webroot, 'public')}/.htaccess ]"
          execute :rm, "#{current_path}/#{fetch(:webroot, 'public')}/.htaccess"
        end
        
        execute :ln, '-s', "#{current_path}/#{fetch(:webroot, 'public')}/htaccess.#{fetch(:stage)}", "#{current_path}/#{fetch(:webroot, 'public')}/.htaccess"
      end
      
      # If there a robots.txt file for the stage exists
      if test " [ -f #{current_path}/#{fetch(:webroot, 'public')}/robots.#{fetch(:stage)}.txt ]"
        if test " [ -f #{current_path}/#{fetch(:webroot, 'public')}/robots.txt ]"
          execute :rm, "#{current_path}/#{fetch(:webroot, 'public')}/robots.txt"
        end
      
        execute :ln, '-s', "#{current_path}/#{fetch(:webroot, 'public')}/robots.#{fetch(:stage)}.txt", "#{current_path}/#{fetch(:webroot, 'public')}/robots.txt"
      end
    end
  end
  
  desc "Revert the database"
  task :revert_database do
    on roles(:db) do
      last_release = capture(:ls, '-xr', releases_path).split.first
      last_release_path = releases_path.join(last_release)
      
      within "#{last_release_path}/#{fetch(:app_webroot, 'public')}" do
      	execute :drush, "-y sql-drop -l #{fetch(:site_url)} &&", %{$(drush sql-connect -l #{fetch(:site_url)}) < #{last_release_path}/db.sql}
      end
    end
  end
  
  desc "Backup the database"
  task :dbbackup do
    invoke "drush:sqldump"
  end
end
