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
  desc "Copy Drupal and web server configuration files"
  task :settings do
    on roles(:app) do
      fetch(:site_folder).each do |folder|
        if test " [ -f #{current_path}/public/sites/#{folder}/settings.php ]"
          execute :rm, "-f", "#{current_path}/public/sites/#{folder}/settings.php"
        end
        execute :ln, '-s', "#{current_path}/public/sites/#{folder}/settings.#{fetch(:stage)}.php", "#{current_path}/public/sites/#{folder}/settings.php"
      end
        
      # If a .htaccess file for the stage exists
      if test " [ -f #{current_path}/public/htaccess.#{fetch(:stage)} ]"
        # If there is currently an .htaccess file
        if test " [ -f #{current_path}/public/.htaccess ]"
          execute :rm, "#{current_path}/public/.htaccess"
        end
        
        execute :ln, '-s', "#{current_path}/public/htaccess.#{fetch(:stage)}", "#{current_path}/public/.htaccess"
      end
      
      # If there a robots.txt file for the stage exists
      if test " [ -f #{current_path}/public/robots.#{fetch(:stage)}.txt ]"
        if test " [ -f #{current_path}/public/robots.txt ]"
          execute :rm, "#{current_path}/public/robots.txt"
        end
      
        execute :ln, '-s', "#{current_path}/public/robots.#{fetch(:stage)}.txt", "#{current_path}/public/robots.txt"
      end
    end
  end
  
  desc "Revert the database"
  task :revert_database do
    on roles(:db) do
      within "#{release_path}/public" do
      	execute :drush, "-y sql-drop -l #{fetch(:site_url)} &&", %{$(drush sql-connect -l #{fetch(:site_url)}) < #{release_path}/db.sql}
      end
    end
  end
  
  desc "Backup the database"
  task :dbbackup do
    invoke "drush:sqldump"
  end
end
