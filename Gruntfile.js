/**
 * Gruntfile
 *
 * This Node script is executed when you run `grunt`.
 * It's purpose is to load the Grunt tasks in your project's `tasks`
 * folder, and allow you to add and remove tasks as you see fit.
 * For more information on how this works, check out the `README.md`
 * file that was generated in your `tasks` folder.
 *
 * WARNING:
 * Unless you know what you're doing, you shouldn't change this file.
 * Check out the `tasks` directory instead.
 */
'use strict';
module.exports = function(grunt) {
  // Load grunt contrib tasks automatically
  require('load-grunt-tasks')(grunt);

  // Initialize configuration with package.json data
  grunt.initConfig({
    'pkg': grunt.file.readJSON('package.json'),
    behat: {
      src: 'tests/behat/features/***/**/*',
      options: {
        maxProcesses: 5,
        bin: './tests/behat/bin/behat',
        junit: {
          output_folder: 'tests/test_results/'
        }
      }
    }
  });

  grunt.registerTask('behatJenkinsTest', 'Execute Behat for BDD testing', function () {
    // The logic here is to allow Jenkins to insert custom environment variables
    // which are than passed along to Behat in as parameters for using specific
    // Behat profiles. As projects in Jenkins appear to have different naming conventions
    // i.e. 'dev' vs 'Dev' it is important for the dev to customize not only the
    // post-build task in Jenkins but the string to match against in this gruntfile denoted
    // in the comments below
    var target = grunt.option('buildDisplay');
    if (target) {
      // Requires Customization
      if (target.indexOf('dev') > -1){
        grunt.config.merge({
          behat: {
            options: {
              config: './tests/behat/behat.jenkins.yml',
              flags: '-p dev'
            }
          }
        });
      // Requires Customization
      } else if(target.indexOf('stage') > -1) {
        grunt.config.merge({
          behat: {
            options: {
              config: './tests/behat/behat.jenkins.yml',
              flags: '-p stage'
            }
          }
        });
      } else {
        grunt.fatal('Select either Dev or Stage Behat Profiles');
      }
      // Don't allow test to continue if it doesn't match one of the Behat Profiles
    } else {
      grunt.fatal('Select either Dev or Stage Behat Profiles');
    }
    grunt.task.run('behat')
  });

  grunt.registerTask('behatTest', 'Execute Behat for BDD testing', function () {
    grunt.config.merge({
      behat: {
        options: {
          config: './tests/behat/behat.yml'
        }
      }
    });
    grunt.task.run('behat')
  });

  // Load the include-all library in order to require all of our grunt
  // configurations and task registrations dynamically.
  var includeAll;
  try {
    includeAll = require('include-all');
  } catch (e0) {
    console.error('Could not find `include-all` module.');
    console.error('Skipping grunt tasks...');
    console.error('To fix this, please run:');
    console.error('npm install include-all --save`');
    console.error();

    grunt.registerTask('default', []);
    return;
  }

  /**
   * Loads Grunt configuration modules from the specified
   * relative path. These modules should export a function
   * that, when run, should either load/configure or register
   * a Grunt task.
   */
  function loadTasks(relPath) {
    return includeAll({
      dirname: require('path').resolve(__dirname, relPath),
      filter: /(.+)\.js$/
    }) || {};
  }

  /**
   * Invokes the function from a Grunt configuration module with
   * a single argument - the `grunt` object.
   */
  function invokeConfigFn(tasks) {
    for (var taskName in tasks) {
      if (tasks.hasOwnProperty(taskName)) {
        tasks[taskName](grunt);
      }
    }
  }

  // Load task functions
  var taskConfigurations = loadTasks('./tasks/config'),
      registerDefinitions = loadTasks('./tasks/register');

  // Ensure that a default task exists
  if (!registerDefinitions.default) {
    registerDefinitions.default = function (grunt) { grunt.registerTask('default', []); };
  }

  // Run task functions to configure Grunt.
  invokeConfigFn(taskConfigurations);
  invokeConfigFn(registerDefinitions);
};
