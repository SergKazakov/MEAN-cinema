do ->
  passwordMatch = ->
    require : 'ngModel'
    scope : otherModelValue : '=passwordMatch'
    link : (scope, element, attributes, ngModel) ->

      ngModel.$validators.compareTo = (modelValue) ->
        modelValue is scope.otherModelValue

      scope.$watch 'otherModelValue', ->
        ngModel.$validate()

  angular
    .module 'cinema'
    .directive 'passwordMatch',  passwordMatch
