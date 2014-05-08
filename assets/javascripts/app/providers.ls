angular, constants <- define <[angular constants angularfire]>

providers = angular.module \gosol.providers, <[firebase]>

providers.factory \ideasFactory do
  [\Firebase \$firebase (Firebase, $firebase)->
    $firebase(new Firebase(constants.ideas))
  ]

providers.factory \ideaFactory do
  [\Firebase \$firebase (Firebase, $firebase)->
    (id)-> $firebase(new Firebase("#{constants.ideas}/#id"))
  ]
