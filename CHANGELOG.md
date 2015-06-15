## 1.1.15 (6 January, 2015)
- Updated to 1.1.20 of puppet-forumone, resolves mailcatcher issue
- Removed hard-coded references to "public" webroot
- Switched to use load-grunt-tasks instead of manually declaring then in Gruntfile.js

## 1.1.14 (17 November, 2014)
- Changed ".cap" to ".rake" to make more clear they are Rake tasks
- Refactored tasks to allow for different platforms
- Added documentation to Drupal platform add-on and tasks
- Added build script tasks for rsync
- Added tasks and platform for WordPress and WP-CLI
- Updated to 1.1.19 of puppet-forumone
- Adding yeoman templates
- Adding .gitattributes to control LF for shell scripts
- Updating default PHP version to 5.4
- Updating drupal.make theme to use gesso contrib
- Updating Rake tasks for WordPress

## 1.1.13 (13 June, 2014)
- Added Capistrano task to copy database from a drush alias `cap dev drush:sqlsync source=@site.stage`
- Added Capistrano task to copy files from a drush alias `cap dev drush:rsync source=@site.stage`
- Added ability to have a Vagrantfile.local file that will override settings in the checked in Vagrantfile
- Added example drush alias file
- Added post-provision example script that copies configuration files and drush aliases if they exist
- Updated to 1.1.18 of puppet-forumone
- Added configuration to example settings.vm.php to disable Google Analytics, Secure Pages and core search indexing
- Updated max_execution_time for Drupal to 180 seconds
- Updated example post-provision script to copy .htaccess if it exists
- Added support for vagrant-cachier plugin
- Fixed issue with copying drush aliases when they do not exist
- Forced version 1.0.3 of Librarian Puppet to prevent issue with CentOS Ruby version

## 1.1.12 (9 May, 2014)
- Changing meaning of roles. App is where Drupal is intended to live, so it symlinks settings, htaccess, etc. App is where Varnish is cleared. DB is where drush commands that affect the database are executed.

## 1.1.11 (8 May, 2014)
- Test for the readability of /etc/varnish/secret before trying to use varnishadm
- Updated to new format of references for Librarian
- Copy robots.txt for stage
- Execute drush commands on all sites defined in :site_url
- Added memcache module to drush.make

## 1.1.10 (11 April, 2014)
- Added custom SSH configuration
- Changed to use array for Drupal sites and host names to support multi-site deployments

## 1.1.9 (3 April, 2014)
- Added example drupal settings.php file for VM
- Added example post-provision script
- Updated to 1.1.14 of puppet-forumone
- Changed execution of post-provision script to use source to avoid issues with NTFS
- Changed npm install to use `--no-bin-links` to avoid NTFS issues
- Replace project-specific paths in Gruntfile to more useful defaults
- Added host specification for Acquia
- Updating to PHP 5.3 from IUS
- Changed starting database name and user/password to be less drupal specific

## 1.1.8 (19 March, 2014)
- Updated to use 1.1.12 of puppet-forumone

## 1.1.7 (12 March, 2014)
- Updated to use 1.1.11 of puppet-forumone

## 1.1.6 (12 March, 2014)
- Fixed defect in post provision scripts

## 1.1.5 (11 March, 2014)
- Updated to use 1.1.10 of puppet-forumone
- Removing unnecessary overrides of capistrano scripts
- Switched to use Librarian to manage puppet modules
