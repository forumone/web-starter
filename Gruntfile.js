module.exports = function(grunt) {
  grunt
      .initConfig({
        pkg : grunt.file.readJSON('package.json'),
        compass : { // Task
          dev : { // Target
            options : { // Target options
              basePath: 'public/sites/all/themes/mcc_theme/',
              outputStyle: 'expanded',
              noLineComments: false,
              bundleExec: true
            }
          },
          staging : { // Target
            options : { // Target options
              basePath: 'public/sites/all/themes/mcc_theme/',
              outputStyle: 'compressed',
              noLineComments: true,
              force: true,
              bundleExec: true
            }
          },
        },
        watch : {
          compass : {
            files : [ 'public/sites/all/themes/mcc_theme/sass/*.scss', 'public/sites/all/themes/mcc_theme/sass/**/*.scss' ],
            tasks : [ 'compass:dev' ]
          }
        }
      });

  var stage = grunt.option('stage') || 'dev';
  
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-compass');

  grunt.registerTask('default', [ 'compass:' + stage ]);
};
