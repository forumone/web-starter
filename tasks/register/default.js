module.exports = function (grunt) {
  grunt.registerTask('default', [
    'build',
    'browserSync', // MUST run before watch task(s)
    'simple-watch'
  ]);
};
