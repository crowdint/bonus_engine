bonusAdminApp.factory "User", ($resource) ->
  $resource("/api/admin/users/:id", {id: '@id'},
  {
   get:    {method: 'GET'},
   save:   {method: 'POST'},
   query:  {method: 'GET', isArray: true},
   remove: {method: 'DELETE'},
   delete: {method: 'DELETE'}
   update: {method: "PUT"}
  })