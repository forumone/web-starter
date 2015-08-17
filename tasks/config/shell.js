module.exports = function(grunt) {
  grunt.config.merge({
    shell : {
      patternlab: {
        command : 'php core/builder.php -g',
        options : {
          execOptions : {
            cwd : '<%= pkg.themePath %>/pattern-lab'
          }
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-shell');
}
