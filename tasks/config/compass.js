module.exports = function(grunt) {

  grunt.config.merge({
    compass: {
      options: {
        config: '<%= pkg.theme_path %>/config.rb,'
      },
      dev: {
        options: {
          outputStyle: 'expanded',
          noLineComments: false,
          bundleExec: true,
        },
      },
      stage: {
        options: {
          outputStyle: 'compressed',
          noLineComments: true,
          force: true,
          bundleExec: true,
        },
      },
    },
    watch: {
      compass: {
        files: [ '<%= pkg.theme_path %>/sass/**/*.scss' ],
        tasks: [ 'compass:dev' ]
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
};
