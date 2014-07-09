Rake::Task['deploy:cleanup'].clear
Rake::Task['deploy:cleanup_rollback'].clear
Rake::Task["deploy:finishing"].enhance ["web:restart"]

# Symlink appropriate folder and settings
Rake::Task["deploy:symlink:release"].enhance do
  Rake::Task["deploy:symlink:web"].invoke
  Rake::Task["deploy:symlink:settings"].invoke
end

# Add the build tasks if necessary
Rake::Task["deploy:updating"].enhance ["web:add_build"]

# Load the platform specific add-on
Rake::Task["deploy:starting"].enhance ["web:load_platform"]

namespace :load do
  task :defaults do
    set :platform, "drupal"
  end
end

namespace :web do
  task :load_platform do
    load "capistrano/#{fetch(:platform)}.rb"
  end

  # Run our build check after rsync:stage
  task :add_build do
    Rake::Task.define_task("rsync:stage") do
      invoke "web:run_build"
    end
  end
  
  # Only run the build if we stage rsync
  task :run_build do
    if ENV["ignore_rsync_stage"].nil?
      invoke "web:build"
    end
  end
  
  desc "Run application build scripts"
  task :build do
  end
  
  namespace :varnish do
    desc "Ban all URLs for a site"
    task :ban do
      on roles(:web) do
        # Make sure we have access to the varnish secret file
        if test " [ -r /etc/varnish/secret ]"
          fetch(:site_url).each do |site|
            execute :varnishadm, "'ban req.http.host ~ #{site}'"
          end
        end
      end
    end
  end
  
  desc "Run any tasks after deployment"
  task :restart do
    invoke "web:varnish:ban"
  end
end

namespace :deploy do
  desc "Installs current platform on remote host"
  task :install => [:check, :starting, :started, :updating, :updated, :publishing] do
    invoke "#{fetch(:platform)}:install"
    invoke "deploy:published"
    invoke "deploy:finishing"
    invoke "deploy:finished"
  end
  
  namespace :symlink do
    desc "Set application webroot"
    task :web do
      on roles(:app) do
        execute :rm, '-rf', deploy_to + "/#{fetch(:webroot)}"
        execute :ln, '-s', "#{current_path}/#{fetch(:app_webroot, 'public')}", deploy_to + "/#{fetch(:webroot)}"
      end
    end

    task :settings do
      invoke "#{fetch(:platform)}:settings"
    end
  end
  
  desc 'Clean up old releases'
  task :cleanup do
    on roles :all do |host|
      releases = capture(:ls, '-x', releases_path).split
      if releases.count >= fetch(:keep_releases)
        info t(:keeping_releases, host: host.to_s, keep_releases: fetch(:keep_releases), releases: releases.count)
        directories = (releases - releases.last(fetch(:keep_releases)))
        if directories.any?
          directories_str = directories.map do |release|
            releases_path.join(release)
          end.join(" ")
          execute :chmod, '-R', 'u+rw', directories_str
          execute :rm, '-rf', directories_str
        else
          info t(:no_old_releases, host: host.to_s, keep_releases: fetch(:keep_releases))
        end
      end
    end
  end
  
  desc 'Remove and archive rolled-back release.'
  task :cleanup_rollback do
    on roles(:all) do
      last_release = capture(:ls, '-xr', releases_path).split.first
      last_release_path = releases_path.join(last_release)
      if test "[ `readlink #{current_path}` != #{last_release_path} ]"
        execute :tar, '-czf',
          deploy_path.join("rolled-back-release-#{last_release}.tar.gz"),
        last_release_path
        execute :chmod, '-R', 'u+rw', last_release_path
        execute :rm, '-rf', last_release_path
      else
        debug 'Last release is the current release, skip cleanup_rollback.'
      end
    end
  end
end
