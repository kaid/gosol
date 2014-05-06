exports.config = {
    "modules": [
        "copy",
        "server",
        "jshint",
        "csslint",
        "require",
        "minify-js",
        "minify-css",
        "live-reload",
        "bower",
        "livescript",
        "stylus",
        "html-templates"
    ],

    "htmlTemplates": {
        "extensions": ["html"]
    },

    "server": {
        "path": "server.ls",
        "views": {
            "compileWith": "html",
            "extension": "html"
        },
        "defaultServer": {
            "enabled": true
        }
    }
}
