require ['jquery',
  'react',
  'backbone',
  'routers/main',
  'jquery_ujs'], ($,
  React,
  Backbone,
  MainRouter) ->

  $ ->
    new MainRouter
    Backbone.history.start()
