require.config do
  urlArgs: "b=#{(new Date()).getTime()}"
  paths:
    jquery: "vendor/jquery/jquery"
    angular: "vendor/angular/angular"
    "angular-route": "vendor/angular-route/angular-route"
  shim:
    "angular":
      exports: "angular"
    "angular-route":
      deps: <[angular]>
      exports: "angular-route"
  deps: <[app app/routes]>
