#= require_self
#= require ui/comments
#= require ui/posts
#= require ui/common
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./routers

window.Blog =
  Models: {}
  Collections: {}
  Routers: {}
  Ui: {}

$ ->
  # initialize the backbone router
  new Blog.Routers.Main()
  Backbone.history.start()
