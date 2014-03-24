define ['backbone',
  'backbone.relational'], (Backbone) ->

  class CommentModel extends Backbone.RelationalModel

    urlRoot: ->
      post = @get('post') or @collection.post
      "/posts/#{post.id}/comments"
