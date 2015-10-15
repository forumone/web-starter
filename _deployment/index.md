---
title: Continuous Integration and Deployment
---

The Web Starter Kit comes with functionality to deploy changes
automatically.

It's built on the following tools:

-   [Grunt](http://gruntjs.com)
-   [Capistrano](http://capistranorb.com/)

Grunt is used to run build tasks such as:

-   Compiling SASS into CSS
-   Compiling and minifying JS
-   Running unit tests

Capistrano is used to deploy to remote environments and run remote
commands such as:

-   Back up database
-   Deploy code
-   Run updates and configuration management tasks
-   Clear reverse proxy cache

{% include menus/deployment.md %}
