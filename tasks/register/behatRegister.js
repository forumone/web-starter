module.exports = function (grunt) {

    // Point to local Behat default Profile
    grunt.registerTask('behatLocal', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: {
                options: {
                    config: './tests/behat/behat.yml'
                }
            }
        });
        grunt.task.run('behat')
    });

    // Point to local Behat Selenium
    grunt.registerTask('behatLocalSelenium', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: {
                options: {
                    config: './tests/behat/behat.yml',
                    flags: '-p local-selenium'
                }
            }
        });
        grunt.task.run('behat')
    });

    // Point to Jenkins Dev environment
    grunt.registerTask('behatJenkinsDev', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: {
                options: {
                    config: './tests/behat/behat.jenkins.yml',
                    flags: '-p dev'
                }
            }
        });
        grunt.task.run('behat')
    });

    // Point to Jenkins Stage environment
    grunt.registerTask('behatJenkinsStage', 'Execute Behat for BDD testing', function () {
        grunt.config.merge({
            behat: {
                options: {
                    config: './tests/behat/behat.jenkins.yml',
                    flags: '-p stage'
                }
            }
        });
        grunt.task.run('behat')
    });

};
