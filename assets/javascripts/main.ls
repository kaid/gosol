require.config do
  urlArgs: "b=#{(new Date()).getTime()}"

  paths:
    jquery: "vendor/jquery/jquery"
    firebase: "vendor/firebase/firebase"
    angular: "vendor/angular/angular"
    angularfire: "vendor/angularfire/angularfire"
    "angular-route": "vendor/angular-route/angular-route"
    "firebase-simple-login": "vendor/firebase-simple-login/firebase-simple-login"

  shim:
    "firebase":
      exports: "firebase"
    "firebase-simple-login":
      deps: <[firebase]>
      exports: "firebase-simple-login"
    "angular":
      exports: "angular"
    "angular-route":
      deps: <[angular]>
      exports: "angular-route"
    "angularfire":
      deps: <[firebase firebase-simple-login angular]>
      exports: "angularfire"

  deps: <[app/init]>
