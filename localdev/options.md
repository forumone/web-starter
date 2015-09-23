---
layout: default
title: Hiera Options
---

Hiera allows settings to be changed for a variety of services within the
virtual machine. These changes may be made to any of the YAML files that
contain configuration, though some configuration options may exist in
the host or platform configuration that would need to be overridden in
the host configuration.

<span id="general"></span>General
---------------------------------

+--------------------------+--------------------------+--------------------------+
| Variable                 | Description              | Default                  |
+==========================+==========================+==========================+
| forumone::ports          | Ports that are opened in | -   80                   |
|                          | the firewall             | -   443                  |
|                          |                          | -   1080                 |
|                          |                          | -   8080                 |
|                          |                          | -   8081                 |
|                          |                          | -   18983                |
|                          |                          | -   8983                 |
|                          |                          | -   3306                 |
|                          |                          | -   13306                |
+--------------------------+--------------------------+--------------------------+
| classes                  | Puppet classes applied   | -   forumone             |
|                          | to the VM; used to add   | -   forumone::ssh\_confi |
|                          | additional classes from  | g                        |
|                          | Puppetforge, etc.        |                          |
+--------------------------+--------------------------+--------------------------+

<span id="php"></span>PHP
-------------------------

  --------------------------------------------------------------------------
  Variable                 Description              Default
  ------------------------ ------------------------ ------------------------
  forumone::php::prefix    PHP version installed;   php54
                           note this is the package 
                           name prefix to use, e.g. 
                           \[prefix\]-common        

  forumone::php::modules   PHP modules installed    
  --------------------------------------------------------------------------

<span id="drush"></span>Drush
-----------------------------

  Variable                   Description                  Default
  -------------------------- ---------------------------- ---------
  forumone::drush::version   Version of Drush installed   7.x-5.9

<span id="database"></span>Database
-----------------------------------

+--------------------------+--------------------------+--------------------------+
| Variable                 | Description              | Default                  |
+==========================+==========================+==========================+
| forumone::database::serv | Whether the database     | true                     |
| er                       | component is installled  |                          |
|                          | as a server              |                          |
+--------------------------+--------------------------+--------------------------+
| forumone::database::vers | Version of Percona       | 5.5                      |
| ion                      | installed                |                          |
+--------------------------+--------------------------+--------------------------+
| forumone::database::mana | Whether the Percona      | true                     |
| ge\_repo                 | repository configuration |                          |
|                          | is controlled by Puppet  |                          |
+--------------------------+--------------------------+--------------------------+
| forumone::database::conf | Configuration included   | -   mysqld/log\_bin:     |
| iguration                | in my.cnf                |     absent               |
+--------------------------+--------------------------+--------------------------+

<span id="webserver"></span>Web Server
--------------------------------------

  Variable                         Description                                   Default
  -------------------------------- --------------------------------------------- ---------
  forumone::webserver::webserver   Which web server installed, apache or nginx   nginx
  forumone::webserver::port        Port that the web server is listening on      8080

### <span id="apache"></span>Apache

  Variable                                           Description                            Default
  -------------------------------------------------- -------------------------------------- ---------
  forumone::webserver::apache\_startservers          Number of servers to start             8
  forumone::webserver::apache\_minspareservers       Minimum number of spare servers        5
  forumone::webserver::apache\_maxspareservers       Maximum number of spare servers        16
  forumone::webserver::apache\_maxclients            Maximum number of clients              16
  forumone::webserver::apache\_maxrequestsperchild   Maximum number of requests per child   200

### <span id="nginx"></span>Nginx

+--------------------------+--------------------------+--------------------------+
| Variable                 | Description              | Default                  |
+==========================+==========================+==========================+
| forumone::webserver::ngi | Nginx configuration      | -   client\_max\_body\_s |
| nx\_conf                 |                          | ize                      |
|                          |                          |     200m                 |
|                          |                          | -   client\_body\_buffer |
|                          |                          | \_size                   |
|                          |                          |     2m                   |
|                          |                          | -   set\_real\_ip\_from  |
|                          |                          |     127.0.0.1            |
|                          |                          | -   real\_ip\_header     |
|                          |                          |     X-Forwarded-For      |
+--------------------------+--------------------------+--------------------------+
| forumone::webserver::ngi | Number of worker         | 1                        |
| nx\_worker\_processes    | processes                |                          |
+--------------------------+--------------------------+--------------------------+
| forumone::webserver::php | Path to PHP-FPM socket   | /var/run/php-fpm.sock    |
| \_fpm\_listen            |                          |                          |
+--------------------------+--------------------------+--------------------------+

{% include menus/localdev.md %}
