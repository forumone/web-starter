# Revert the database when a rollback occurs
Rake::Task["deploy:rollback_release_path"].enhance do
  invoke "wordpress:revert_database"
end

# Backup the database when publishing a new release
Rake::Task["deploy:published"].enhance ["wordpress:dbbackup"]

# After publication run updates
Rake::Task["deploy:published"].enhance do 
  Rake::Task["wpcli:update"].invoke
end

namespace :wordpress do
  task :settings do
    on roles(:app) do
      if test " [ -f #{current_path}/#{fetch(:webroot, 'public')}/wp-config.php ]"
        execute :rm, "-f", "#{current_path}/#{fetch(:webroot, 'public')}/wp-config.php"
      end
      
      execute :ln, '-s', "#{current_path}/#{fetch(:webroot, 'public')}/wp-config.#{fetch(:stage)}.php", "#{current_path}/#{fetch(:webroot, 'public')}/wp-config.php"
        
      # If a .htaccess file for the stage exists
      if test " [ -f #{current_path}/#{fetch(:webroot, 'public')}/htaccess.#{fetch(:stage)} ]"
        # If there is currently an .htaccess file
        if test " [ -f #{current_path}/#{fetch(:webroot, 'public')}/.htaccess ]"
          execute :rm, "#{current_path}/#{fetch(:webroot, 'public')}/.htaccess"
        end
        
        execute :ln, '-s', "#{current_path}/#{fetch(:webroot, 'public')}/htaccess.#{fetch(:stage)}", "#{current_path}/#{fetch(:webroot, 'public')}/.htaccess"
      end
    end
  end
  
  task :dbbackup do
    invoke "wpcli:dbexport"
  end
  
  desc "Revert the database"
  task :revert_database do
    on roles(:db) do
      within "#{release_path}/#{fetch(:app_webroot, 'public')}" do
        execute :gunzip, "#{release_path}/db.sql.gz"
        execute :wp, "db import", "#{release_path}/db.sql"
      end
    end
  end
end
