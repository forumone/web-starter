---
layout: default
title: Included Platforms
---

#### Drupal

This Platform contains configuration necessary to install and run Drupal
7 and 8 with some settings specified to do light weight optimizations.
This includes the following software and configuration:

-   A web server -- depending on the Host it may be Apache or nginx
-   PHP, with version and processor depending on the Host, requiring the
    following modules:
    -   XML
    -   PDO
    -   MBString
    -   MySQL
    -   XDebug
    -   GD
-   Drush
-   Mailcatcher
-   PHP.ini settings:
    -   display\_errors = "On"
    -   memory\_limit = "256M"
    -   upload\_max\_size = "50M"
    -   post\_max\_size = "100M"
    -   sendmail\_path = "/usr/bin/env mailcatcher" -- used to capture
        email with Mailcatcher
    -   max\_execution\_time = "180"
-   MySQL settings:
    -   max\_allowed\_packets = 100M
    -   innodb\_file\_per\_table
    -   query\_cache\_size = 128M
    -   table\_open\_cache = 2048
    -   table\_cache = 1024
    -   thread\_cache\_size = 4
    -   tmp\_table\_size = 128
    -   max\_heap\_table\_size = 128M
    -   join\_buffer\_size = 1M
    -   myisam\_sort\_buffer\_size = 8M
    -   sort\_buffer\_size = 2M

#### Wordpress

This Platform contains configuration necessary to install and run
Wordpress 3 with some settings specified to do light weight
optimizations. This includes the following software and configuration:

-   A web server -- depending on the Host it may be Apache or nginx
-   PHP, with version and processor depending on the Host, requiring the
    following modules:
    -   XML
    -   PDO
    -   MBString
    -   MySQL
    -   XDebug
    -   GD
-   Mailcatcher
-   PHP.ini settings:
    -   display\_errors = "On"
    -   memory\_limit = "256M"
    -   upload\_max\_size = "50M"
    -   post\_max\_size = "100M"
    -   sendmail\_path = "/usr/bin/env mailcatcher" -- used to capture
        email with Mailcatcher
    -   max\_execution\_time = "180"
-   MySQL settings:
    -   max\_allowed\_packets = 100M
    -   innodb\_file\_per\_table
    -   query\_cache\_size = 128M
    -   table\_open\_cache = 2048
    -   table\_cache = 1024
    -   thread\_cache\_size = 4
    -   tmp\_table\_size = 128
    -   max\_heap\_table\_size = 128M
    -   join\_buffer\_size = 1M
    -   myisam\_sort\_buffer\_size = 8M
    -   sort\_buffer\_size = 2M

#### AngularJS

This Platform contains configuration necessary to develop Javascript
applications using AngularJS, Backbone, etc. This includes the following
software and configuration:

-   A web server -- depending on the Host it may be Apache or nginx
-   NodeJS
-   Ruby -- default version is 1.9.3p484

{% include menus/localdev.md %}
