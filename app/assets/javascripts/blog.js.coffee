define ['backbone'], (Backbone) ->
  Blog =
    Models: {}
    Collections: {}
    Routers: {}
    Ui: {}
#= require_self
#= require ui/comments
#= require ui/posts
#= require ui/common
#= require models/comment
#= require collections/comments
#= require collections/posts
#= require models/post
#= require_tree ./routers


$ ->
  # initialize the backbone router
  new Blog.Routers.Main()
  Backbone.history.start()
