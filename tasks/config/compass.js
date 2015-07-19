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
  });

  grunt.loadNpmTasks('grunt-contrib-compass');
};
