module.exports = function (grunt) {
  grunt.registerTask('buildPatternlab', [
    'copy:patternlabStyleguide',
    'shell:patternlab'
  ]);
};
