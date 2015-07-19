module.exports = function(grunt) {
  grunt.config.merge({
    copy : {
      patternlabStyleguide : {
        expand : true,
        cwd : '<%= pkg.themePath %>/patternlab/core/styleguide/',
        src : '**',
        dest : '<%= pkg.themePath %>/patternlab/public/styleguide/'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-copy');
}