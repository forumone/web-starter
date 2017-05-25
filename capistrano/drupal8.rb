# Revert the database when a rollback occurs
Rake::Task["deploy:rollback_release_path"].enhance do
  invoke "drupal8:revert_database"
end

# Backup the database when publishing a new release
Rake::Task["deploy:published"].enhance ["drupal8:dbbackup"]

# Copy drush aliases after linking the new release
Rake::Task["deploy:symlink:release"].enhance ["drush:initialize"]

# After publication run updates
Rake::Task["deploy:published"].enhance do
  Rake::Task["drush:update"].invoke
end

namespace :drupal8 do
  desc "Install Drupal"
  task :install do
    invoke 'drush:siteinstall'
  end

  desc "Copy Drupal and web server configuration files"
  task :settings do
    on roles(:app) do
      fetch(:site_folder).each do |folder|
        # Find and link settings.php
        if test " [ -e #{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.php ]"
          execute :rm, "-f", "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.php"
        end
        execute :ln, '-s', "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.#{fetch(:stage)}.php", "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.php"

        # Find and link services.yml (if it exists)
        if test " [ -e #{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/services.#{fetch(:stage)}.yml ]"
          if test " [ -e #{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/services.yml ]"
            execute :rm, "-f", "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/services.yml"
          end
          execute :ln, '-s', "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/services.#{fetch(:stage)}.yml", "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/services.yml"
        end

        # Set permissions on settings files and directory so Drupal doesn't complain. The permission values are set in lib/capistrano/tasks/drush.rake.
        execute :chmod, fetch(:settings_file_perms), "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/settings.#{fetch(:stage)}.php"
        if test " [ -e #{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/services.yml ]"
          execute :chmod, fetch(:settings_file_perms), "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}/services.#{fetch(:stage)}.yml"
        end
        execute :chmod, fetch(:site_directory_perms), "#{current_path}/#{fetch(:webroot, 'public')}/sites/#{folder}"
      end
    end
  end

  desc "Revert the database"
  task :revert_database do
    on roles(:db) do
      last_release = capture(:ls, '-xr', releases_path).split.first
      last_release_path = releases_path.join(last_release)

      within "#{last_release_path}/#{fetch(:app_webroot, 'public')}" do
        execute :gunzip, "#{last_release_path}/db.sql.gz"
        execute :drush, "-y sql-drop -l #{fetch(:site_url)[0]} &&", %{$(drush sql-connect -l #{fetch(:site_url)[0]}) < #{last_release_path}/db.sql}
      end
    end
  end

  desc "Backup the database"
  task :dbbackup do
    invoke "drush:sqldump"
  end
end
