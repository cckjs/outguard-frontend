angular.module 'main.controller', []
.controller 'main.indexController', [
  '$scope'
  '$http'
  'main.docService'
  ($scope, $http, docService)->
    $scope.ty = {}
    $scope.ty.docs = [];

    $scope.ty.order = 'time';
    $scope.ty.title = '';
    $scope.ty.query = ()->
      $scope.now = new Date().getTime()
      $scope.ty.docs_url = '/apps/docs.json'
      $scope.ty.docs_params =
        order: $scope.ty.order
        title: $scope.ty.title
        now: $scope.now

    $scope.ty.changeOrder = (order)->
      $scope.ty.order = order
      $scope.ty.query()

    $scope.ty.changeTitle = ()->
      $scope.ty.query()
    $scope.ty.add = (id)->
      console.log $scope.ty.docs[0].json

    $scope.ty.query()

    $scope.my = {};
    $scope.my.docs = [];
    $scope.add = (docId)->
      $http.get("/apps/add_my_doc?page_id=" + docId).then ()->
        $scope.my.query()

    $scope.my.query = ()->
      $scope.now = new Date().getTime()
      $scope.my.docs_url = '/apps/my_docs.json'
      $scope.my.docs_params =
        title: $scope.my.title
        now: $scope.now
    $scope.my.query()
]

