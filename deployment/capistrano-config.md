---
layout: default
title: Capistrano Config
---

There are a number of places where the Capistrano scripts can be
customized to deploy a variety of web platforms.

### General configuration -- deploy/deploy.rb

-   **:application**

    The name of the directory within the deployment target that hosts
    files, can be anything name as long as it is comprised of characters
    that are safe for Unix directories

-   **:repo\_url**

    The Git URL for the repository

-   **:scm**

    Whether deployments should use git or rsync

-   **:deploy\_via**

    Whether to use a remote cache for git, generally recommended

-   **:format**

    The log formatter to use, generally recommended to use :pretty to
    see details

-   **:user\_sudo**

    A boolean value whether the deployment user will have access to sudo

-   **:pty**

    A boolean value whether to use a "pseudo TTY" for the deployment

-   **:linked\_dirs**

    A whitespace delimited hash of which directories to link into the
    release; typically public/sites/default/files for typical Drupal
    installations or public/wp-content/uploads for typical Wordpress
    installations

-   **:keep\_releases**

    Number of releases to keep on the deployment target

-   **:ssh\_options**

    Includes the `config/ssh_config` file to provide custom SSH config
    for deployment

-   **:platform**

    Sets platform to use, this controls various aspects of deployment,
    including which tasks to run to set configuration; each value maps
    to a file in the capistrano directory, e.g. drupal or wordpress

-   **:rsync\_options**

    A whitespace delimited set of options passed to rsync when copying
    files from the deployment host to the target

-   **:rsync\_copy**

    A whitespace delimited set of options passed to rsync when copying
    files from the staging directory on the deployment target to the
    release

-   **:rsync\_cache**

    The location where files are initially copied on the deployment
    target before being copied to the release

-   **web:build**

    Task that runs build operations within the rsync stage directory;
    used when the `ignore_rsync_stage` flag is not set

-   **:app\_webroot**

    The location within the repository that contains the webroot; will
    be symlinked to the :webroot attribute within the deployment target;
    defaults to 'public'

### Stage configuration -- deploy/deploy/\[stage\].rb

-   **:stage**

    The name of the stage, should match the filename

-   **:site\_url**

    A whitespace delimited hash of URLs that the site can be accessed
    on; used to ban from Varnish

-   **:site\_folder**

    A whitespace delimited hash of sites to copy Drupal configuration
    within; used for multi-site deployments

-   **:webroot**

    The webroot on the deployment target; typically public or htdocs or
    docroot

-   **:deploy\_to**

    The location of the deployment target; assumed to have child
    directories for the public webroot as well as shared directories

-   **:tmp\_dir**

    Where temporary files are stores; recommended to be the deployment
    target to ensure user permissions are correct

-   **:branch**

    The refspec that should be deployed to the stage

-   **Roles**
    -   **:app**

        A whitespace delimited hash of hosts to run app tasks on, these
        are hosts that run the application code, so the appropriate
        Drupal or WordPress or Javascript files

    -   **:web**

        A whitespace delimited hash of hosts to run web tasks on, in the
        configured tasks this is only the Varnish bans

    -   **:db**

        A whitespace delimited hash of hosts to run database tasks on,
        this includes backing up the database and applying configuration
        changes

### Drupal configuration -- deploy/deploy.rb

-   **:drupal\_features**

    A boolean value whether the Features module is enabled; defaults to
    true

-   **:drupal\_cmi**

    A boolean value whether the Configuration module is enabled;
    defaults to false

-   **:drupal\_features\_path**

    A whitespace delimited hash or paths to look for Features to revert
    on; defaults to empty; if it is empty all Features will be reverted

-   **:drupal\_db\_updates**

    A boolean value whether to run database updates when deploying;
    defaults to true

### WordPress configuration -- deploy/deploy.rb

-   **:wordpress\_wpcfm**

    A boolean value whether to use WP-CFM to propagate configuration;
    defaults to false

{% include menus/deployment.md %}
