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
      nameTransform: (path)->
        path.match(/template\/(.*)$/)[1]

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

        pouchdb:
          path: "javascripts/vendor/pouchdb/pouchdb-nightly"
          exports: "PouchDB"

      aliases:
        templates: "javascripts/templates"
        pouchdb: "javascripts/vendor/pouchdb/pouchdb-nightly"
        angular: "javascripts/vendor/angular/angular"
        "angular-pouchdb": "javascripts/vendor/angular-pouchdb/angular-pouchdb"
        "angular-route": "javascripts/vendor/angular-route/angular-route"

      noParse: [
        "javascripts/vendor/jquery/jquery"
        "javascripts/vendor/angular/angular"
        "javascripts/vendor/angular-route/angular-route"
      ]
