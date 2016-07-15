module.exports = function(grunt) {
  grunt.config.merge({
    copy : {
      patternlabStyleguide : {
        expand : true,
        cwd : '<%= pkg.themePath %>/pattern-lab/core/styleguide/',
        src : '**',
        dest : '<%= pkg.themePath %>/pattern-lab/public/styleguide/'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-copy');
}
