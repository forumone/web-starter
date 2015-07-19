/**
 * tasks/config/pkg.js
 *
 * Merge configuration from package.json for use throughout tasks.
 */
'use strict';
module.exports = function(grunt) {
  grunt.config.merge({
    pkg: grunt.file.readJSON('package.json')
  });
};
