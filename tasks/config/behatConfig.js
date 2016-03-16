module.exports = function(grunt) {
    grunt.config.merge({
        behat: {
            src: 'tests/behat/features/***/**/*',
            options: {
                maxProcesses: 5,
                bin: './tests/behat/bin/behat',
                junit: {
                    output_folder: 'tests/test_results/'
                }
            }
        }
    });
};
