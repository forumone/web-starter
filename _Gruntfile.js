module.exports = function(grunt) {
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
            tasks : [ 'compass:dev' ]
          }
          {{/use_compass}}
        }
      });

  var stage = grunt.option('stage') || 'dev';
  
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-simple-watch');
  grunt.loadNpmTasks('grunt-contrib-compass');

  grunt.registerTask('default', [ {{#use_compass}}'compass:' + stage {{/use_compass}}]);
};
