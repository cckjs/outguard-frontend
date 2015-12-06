angular.module 'main.service', []
.factory 'main.docService', ['$resource', ($resource)->
  return $resource '/documents/hot_search.json'
]
