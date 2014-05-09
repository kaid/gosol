exports.config =
    modules: [
        "copy"
        "server"
        "jshint"
        "csslint"
        "browserify"
        "minify-js"
        "minify-css"
        "live-reload"
        "bower"
        "livescript"
        "stylus"
        "html-templates"
    ]

    template:
      wrapType: "common"

    htmlTemplates:
      extensions: ["html"]
    
    watch:
      exclude: [/[/\\](\.|~)[^/\\]+$/, /~$/, /#$/, /^\.#/]

    server:
      path: "server.ls"

      views:
        compileWith: "html"
        extension: "html"

      defaultServer:
        enabled: true

    browserify:
      bundles:
        [
          entries: ["javascripts/main.js"]
          outputFile: "bundle.js"
        ]

      shims:
        jquery:
          path: "javascripts/vendor/jquery/jquery"
          exports: "$"

      aliases:
        templates: "javascripts/templates"
        angular: "javascripts/vendor/angular/angular"
        goangular: "javascripts/vendor/goangular/goangular"
        "angular-route": "javascripts/vendor/angular-route/angular-route"

      noParse: [
        "javascripts/vendor/jquery/jquery"
        "javascripts/vendor/angular/angular"
        "javascripts/vendor/goangular/goangular"
        "javascripts/vendor/angular-route/angular-route"
      ]
