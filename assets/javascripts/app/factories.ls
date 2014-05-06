angular <- define <[angular]>

factories = angular.module \gosol.factories, []

<- factories.factory \goals
goals = 
  * id: 1
    name: \goal1
    goals: []
  ...

goals
