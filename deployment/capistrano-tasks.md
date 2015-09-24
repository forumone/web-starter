---
layout: default
title: Capistrano Tasks
---

The Web Starter Kit relies on [Capistrano](http://capistranorb.com) to
deploy changes to remote hosts. This included creation of several new
Capistrano tasks to perform required updates as well as updating default
tasks.

### Deploy namespace

-   **deploy:install**

    Installs the current platform on the remote host

-   **deploy:symlink**

    Links the application webroot -- defaults to 'public' -- to the host
    webroot

### Web namespace

-   **web:build**

    Runs any local build tasks, used for triggering build tasks from the
    rsync staging directory

-   **web:varnish**

    Bans all cache items where the host is like items in the site\_url
    hash

### Drush namespace

-   **drush:drushdir**

    Creates the users's .drush directory if it doesn't exist

-   **drush:aliases**

    Copies drush alias files from the repository to the user's .drush
    directory on the host

-   **drush:initialize**

    Triggers the drush:drushdir and drush:aliases tasks

-   **drush:cc**

    Clears all caches

-   **drush:configuration:sync**

    Synchronizes the configuration exported via the Drupal Configuration
    module

-   **drush:features:revert**

    Reverts Drupal Features, reverts all Features unless the
    `drupal_features_path` value is set

-   **drush:updatedb**

    Runs all pending update hooks

-   **drush:update**

    Runs updates to the Drupal site, including update hooks, clearing
    the cache, reverting Features and synchronizing Configuration as
    configured

-   **drush:siteinstall**

    Installs Drupal on the remote site, can specify which install
    profile to use by passing `profile=[profile]`

-   **drush:sqldump**

    Creates a backup of the database into the current release directory

-   **drush:rsync**

    Copies files from one remote alias to the selected stage, the source
    is specified is specified by passing `source=[alias]`

-   **drush:sqlsync**

    Copies database from one remote alias to the selected stage, the
    source is specified by passing `source=[alias]`

### WPCLI namespace

-   **wpcli:wpcfm:pull**

    Pulls configuration from WP-CFM into the stage

{% include menus/deployment.md %}
