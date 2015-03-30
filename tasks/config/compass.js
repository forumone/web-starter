module.exports = function(grunt) {
  // Test the build mode to use by checking the --environment CLI flag
  var environment = (grunt.option('prod') || grunt.option('production')) ? 'stage' : 'dev';

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
        tasks: [ 'compass:' + environment ],
      },
    },
  });

  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
};
