// BrowserSync
// http://www.browsersync.io/docs/grunt/
module.exports = function(grunt) {
  grunt.config.merge({
    browserSync: {
      options: {
        proxy: "localhost:8081",
        watchTask: true,
      }
      dev: {
        bsFiles: {
          src : [
            '<%= pkg.themePath %>/css/*.css',
            '<%= pkg.themePath %>/pattern-lab/public/**/*.html'
          ]
        },
      }
    },
  });

  grunt.loadNpmTasks('grunt-browser-sync');
};
