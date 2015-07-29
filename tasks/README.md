# About the `tasks` folder

The `tasks` directory is a suite of Grunt tasks and their configurations, bundled for your convenience.  The Grunt integration is mainly useful for bundling front-end assets, (like stylesheets, scripts, & markup templates) but it can also be used to run all kinds of development tasks, from browserify compilation to database migrations.

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, read on!


### Can I customize this for SASS, Angular, client-side Jade templates, etc?

You can modify, omit, or replace any of these Grunt tasks to fit your requirements. You can also add your own Grunt tasks- just add a `someTask.js` file in the `tasks/config` directory to configure the new task, then register it with the appropriate parent task(s) (see files in `tasks/register/*.js`).


### Do I have to use Grunt?

Nope! To disable Grunt integration, just delete your Gruntfile.
