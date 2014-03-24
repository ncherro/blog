require ['jquery',
  'react',
  'backbone'
  'routers/main'], ($,
  React,
  Backbone,
  MainRouter) ->

  $ ->
    new MainRouter
    Backbone.history.start()
