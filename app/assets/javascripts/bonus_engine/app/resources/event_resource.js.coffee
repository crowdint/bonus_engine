bonusApp.factory "Event", ($resource) ->
  $resource("/api/cycles/:cycle_id/events/:id", {id: '@id'},
  {
   get:    {method: 'GET'},
   save:   {method: 'POST'},
   query:  {method: 'GET', isArray: true},
   remove: {method: 'DELETE'},
   delete: {method: 'DELETE'}
   update: {method: "PUT"}
  })