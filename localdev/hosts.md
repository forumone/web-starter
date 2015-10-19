---
layout: default
title: Included Hosts
---

#### Acquia

This host mimics the environment used by Acquia to deploy Drupal sites.
It's not entirely the same because Acquia uses Ubuntu while the Web
Starter Kit uses CentOS, but the packages are very close. This includes
the following software:

-   Apache web server
-   PHP 5.4 mod\_php with the following modules:
    -   APC
    -   PECL memcached
-   Apache Solr 3.6.2 with a collection called "drupal"
-   memcached
-   Varnish 3
-   NodeJS
-   Ruby -- default version is 1.9.3p484

#### Pantheon

This host mimics the environment used by Pantheon to deploy Drupal
sites. It's not entirely the same because Pantheon uses custom
containers while the Web Starter Kit uses CentOS, but the packages are
very close. This includes the following software:

-   nginx web server
-   PHP 5.4 FPM with the following modules:
    -   APC
    -   PECL Redis
-   Apache Solr 3.6.2 with a collection called "drupal"
-   Redis
-   Varnish 3
-   NodeJS
-   Ruby -- default version is 1.9.3p484

#### F1 Dev

This host mimics the environment used by Forum One internally, so is
slightly idiosyncratic to our tools and processes. This includes the
following software:

-   nginx web server
-   PHP 5.4 FPM with the following modules:
    -   XCache
    -   PECL memcached
-   Apache Solr 3.6.2 with a collection called "drupal"
-   memcache
-   Varnish 3
-   NodeJS
-   Ruby -- default version is 1.9.3p484

{% include menus/localdev.md %}
