require ['jquery',
  'react',
  'underscore',
  'backbone',
  'routers/main'], ($,
  React,
  _,
  Backbone,
  MainRouter) ->
  $ ->
    new MainRouter
    Backbone.history.start()
