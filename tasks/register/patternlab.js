module.exports = function (grunt) {
  grunt.registerTask('patternlab', [
    'copy:patternlabStyleguide',
    'compass:patternlab',
    'concurrent:patternlab'
  ]);
};
