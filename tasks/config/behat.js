module.exports = function (grunt) {
    grunt.config.merge({
        behatLocal: {
            src: './tests/behat/features/***/**/*',
            options: {
                config: './tests/behat/behat.yml',
                maxProcesses: 5,
                bin: './tests/behat/bin/behat',
                junit: {
                    output_folder: 'tests/test_results/'
                }
            }
        },
        behatLocalSelenium: {
            src: './tests/behat/features/***/**/*',
            options: {
                config: './tests/behat/behat.yml',
                flags: '-p local-selenium',
                maxProcesses: 5,
                bin: './tests/behat/bin/behat',
                junit: {
                    output_folder: 'tests/test_results/'
                }
            }
        },
        behatJenkinsDev: {
            src: './tests/behat/features/***/**/*',
            options: {
                config: './tests/behat/behat.jenkins.yml',
                flags: '-p dev',
                maxProcesses: 5,
                bin: './tests/behat/bin/behat',
                junit: {
                    output_folder: 'tests/test_results/'
                }
            }
        },
        behatJenkinsStage: {
            src: './tests/behat/features/***/**/*',
            options: {
                config: './tests/behat/behat.jenkins.yml',
                flags: '-p stage',
                maxProcesses: 5,
                bin: './tests/behat/bin/behat',
                junit: {
                    output_folder: 'tests/test_results/'
                }
            }
        }
    });
};
