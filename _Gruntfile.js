module.exports = function(grunt) {
  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  grunt
      .initConfig({
        pkg : grunt.file.readJSON('package.json'),
        {{#use_compass}}
        compass : { // Task
          dev : { // Target
            options : { // Target options
              {{#is_drupal}}
              basePath: '{{app_webroot}}/sites/all/themes/{{drupal_theme}}/',
              {{/is_drupal}}
              {{#is_wordpress}}
              basePath: '{{app_webroot}}/wp-content/themes/{{wordpress_theme}}/',
              {{/is_wordpress}}
              outputStyle: 'expanded',
              noLineComments: false,
              bundleExec: true
            }
          },
          staging : { // Target
            options : { // Target options
              {{#is_drupal}}
              basePath: '{{app_webroot}}/sites/all/themes/{{drupal_theme}}/',
              {{/is_drupal}}
              {{#is_wordpress}}
              basePath: '{{app_webroot}}/wp-content/themes/{{wordpress_theme}}/',
              {{/is_wordpress}}
              outputStyle: 'compressed',
              noLineComments: true,
              force: true,
              bundleExec: true
            }
          },
        },
        {{/use_compass}}
        watch : {
          {{#use_compass}}
          compass : {
            {{#is_drupal}}
            files : [ '{{app_webroot}}/sites/all/themes/{{drupal_theme}}/sass/*.scss', '{{app_webroot}}/sites/all/themes/{{drupal_theme}}/sass/**/*.scss' ],
            {{/is_drupal}}
            {{#is_wordpress}}
            files : [ '{{app_webroot}}/wp-content/themes/{{wordpress_theme}}/sass/*.scss', '{{app_webroot}}/wp-content/themes/{{wordpress_theme}}/sass/**/*.scss' ],
            {{/is_wordpress}}
            tasks : [ 'compass:dev' ]
          }
          {{/use_compass}}
        }
      });

  var stage = grunt.option('stage') || 'dev';

  grunt.registerTask('default', [ {{#use_compass}}'compass:' + stage {{/use_compass}}]);
};
