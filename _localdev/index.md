---
layout: default
title: Local Development Environments
---

The Web Starter Kit comes with the ability to stand up a local
development environment that closely mimics your production environment.

It's built on the following tools:

-   [Vagrant](http://vagrantup.com)
-   [Puppet](http://puppetlabs.com/)
-   [librarian-puppet](http://librarian-puppet.com/)

The Web Starter Kit uses Hiera to control the configuration for the
virtual machine so you don't need to modify the underlying Puppet files.
Updating which packages, services and settings are used is a simple
matter of changing some YAML

The Web Starter Kit is based around the concept of separating
configuration into Hosts, Platforms and Sites. Each holds a piece of the
configuration that can be overridden by the following set, but they
allow you to structure your configuration so that pieces are re-usable.
For example, the configuration for the Drupal Platform includes:

-   A webserver
-   PHP
-   Drush
-   [Mailcatcher](http://mailcatcher.me/)
-   The following PHP modules:
    -   XML
    -   PDO
    -   MBString
    -   MySQL
    -   XDebug
    -   GD
-   And some various configurations for PHP and MySQL

But what it doesn't specify is which webserver it requires or which
version of PHP. Those are left to the Host to have the configuration for
what services and versions it supports. This allows you to mix and match
Hosts and Platforms without having to keep changing the settings.
