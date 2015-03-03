bonusAdminApp.factory "Point", ($resource) ->
  $resource("/api/admin/events/:event_id/reports", {id: '@id'},
  {
   query:  {method: 'GET', isArray: true}
  })