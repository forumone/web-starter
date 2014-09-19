// Gruntfile.js
module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        shell: {
            jekyllBuild: {
                command: 'jekyll build'
            },
            jekyllServe: {
                command: 'jekyll serve --baseurl=""',
                options: {
                	stderr: false,
                	stdout: false
                }
            }
        },
        watch: {
            files: [
                '_includes/*.html',
                '_layouts/*.html',
                '_posts/*.markdown',
                '_config.yml',
                'index.html',
                'localdev/*.html'
            ],
            tasks: ['shell:jekyllBuild', 'shell:jekyllServe'],
            options: {
                interrupt: true,
                atBegin: true,
                livereload: true,
                spawn: true
            }
        }
    });

    grunt.loadNpmTasks('grunt-shell');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('default', ['shell']);
};