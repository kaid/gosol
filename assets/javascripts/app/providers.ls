require \angular
require \goangular

providers = angular.module \gosol.providers, <[goangular]>
root      = \https://goinstant.net/ae10d8f555c8/gosol

providers.config do
  [\$goConnectionProvider ($goConnectionProvider)->
    $goConnectionProvider.$set root
  ]

providers.factory \ideasFactory do
  [\$goKey ($goKey)->
    $goKey("ideas").$sync!
  ]

providers.factory \ideaFactory do
  [\$goKey \ideasFactory ($goKey, ideasFactory)->
    (id)-> ideasFactory.$key(id).$sync!
  ]
