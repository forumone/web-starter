module.exports = function(grunt) {

  grunt.config.merge({
    compass: {
      options: {
        basePath: '<%= pkg.themePath %>',
        config: '<%= pkg.themePath %>/config.rb',
      },
      dev: {
        options: {
          environment: 'development',
          outputStyle: 'expanded',
          noLineComments: false,
          bundleExec: true,
        },
      },
      stage: {
        options: {
          environment: 'production',
          outputStyle: 'compressed',
          noLineComments: true,
          force: true,
          bundleExec: true,
        },
      },
    },
    watch: {
      compass: {
        files: [ '<%= pkg.themePath %>/sass/**/*.scss' ],
        tasks: [ 'compass:dev' ],
      },
    },
  });

  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
};
