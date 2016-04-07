module.exports = function (grunt) {

    // Point to local Behat default Profile
    grunt.registerTask('behatLocal', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: grunt.config.data.behatLocal
        });
        grunt.task.run('behat')
    });

    // Point to local Behat Selenium
    grunt.registerTask('behatLocalSelenium', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: grunt.config.data.behatLocalSelenium
        });
        grunt.task.run('behat')
    });

    // Point to Jenkins Dev environment
    grunt.registerTask('behatJenkinsDev', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: grunt.config.data.behatJenkinsDev
        });
        grunt.task.run('behat')
    });

    // Point to Jenkins Stage environment
    grunt.registerTask('behatJenkinsStage', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: grunt.config.data.behatJenkinsStage
        });
        grunt.task.run('behat')
    });

};
