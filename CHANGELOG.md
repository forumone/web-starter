## 1.1.13 (In progress)
- Added Capistrano task to copy database from a drush alias `cap dev drush:sqlsync source=@site.stage`
- Added Capistrano task to copy files from a drush alias `cap dev drush:rsync source=@site.stage`
- Added ability to have a Vagrantfile.local file that will override settings in the checked in Vagrantfile
- Added example drush alias file
- Added post-provision example script that copies configuration files and drush aliases if they exist
- Updating to 1.1.17 of puppet-forumone

## 1.1.12 (May 9, 2014)
- Changing meaning of roles. App is where Drupal is intended to live, so it symlinks settings, htaccess, etc. App is where Varnish is cleared. DB is where drush commands that affect the database are executed.

## 1.1.11 (May 8, 2014)
- Test for the readability of /etc/varnish/secret before trying to use varnishadm
- Updating to new format of references for Librarian
- Copy robots.txt for stage
- Execute drush commands on all sites defined in :site_url
- Added memcache module to drush.make
