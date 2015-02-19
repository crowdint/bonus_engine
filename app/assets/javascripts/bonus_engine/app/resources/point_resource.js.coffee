bonusApp.factory "Point", ($resource) ->
  $resource("/api/cycles/:cycle_id/events/:event_id/points/:id", {id: '@id'},
  {
   get:    {method: 'GET'},
   save:   {method: 'POST'},
   query:  {method: 'GET', isArray: true},
   remove: {method: 'DELETE'},
   delete: {method: 'DELETE'}
   update: {method: "PUT"}
   me:     {method: 'GET', params: {id: 'me'}}
  })