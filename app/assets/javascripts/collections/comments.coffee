define ['backbone',
  'models/comment'], (Backbone,
  CommentModel) ->

  class CommentsCollection extends Backbone.Collection

    model: CommentModel

    url: ->
      "/posts/#{@post.id}/comments"

    parse: (response) ->
      if response.meta.total_count
        @total_count = response.meta.total_count
      response.comments
