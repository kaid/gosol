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

        d3:
          path: "javascripts/vendor/d3/d3"
          exports: "d3"

      aliases:
        "prelude-ls": "javascripts/vendor/prelude-ls/index"
        templates: "javascripts/templates"
        pouchdb: "javascripts/vendor/pouchdb/pouchdb-nightly"
        angular: "javascripts/vendor/angular/angular"
        "angular-pouchdb": "javascripts/vendor/angular-pouchdb/angular-pouchdb"
        "angular-route": "javascripts/vendor/angular-route/angular-route"
        "angular-bootstrap": "javascripts/vendor/angular-bootstrap/ui-bootstrap-tpls"

      noParse: [
        "javascripts/vendor/d3/d3"
        "javascripts/vendor/prelude-ls/index"
        "javascripts/vendor/jquery/jquery"
        "javascripts/vendor/angular/angular"
        "javascripts/vendor/angular-route/angular-route"
        "javascripts/vendor/angular-bootstrap/ui-bootstrap-tpls"
      ]
