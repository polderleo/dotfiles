module.exports = function (config) {
    config.set({
        frameworks: ['mocha'],
        plugins: ['karma-esbuild', 'karma-mocha', 'karma-chrome-launcher', 'karma-spec-reporter'],
        files: ['webview/src/test/browser/**/*.ts'],
        preprocessors: {
            'webview/src/test/browser/**/*.ts': ['esbuild'],
        },
        reporters: ['spec'],
        port: 9876,  // karma web server port
        colors: true,
        logLevel: config.LOG_INFO,
        browsers: ['ChromeHeadless'],
        autoWatch: false,
        // singleRun: false, // Karma captures browsers, runs the tests and exits
        concurrency: Infinity,
        esbuild: {},
        specReporter: {
            showSpecTiming: true,
        },
        browserDisconnectTimeout: 30000
    })
}
