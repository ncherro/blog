define ['backbone',
  'models/comment',
  'collections/comments',
  'backbone.jsonapi'], (Backbone,
  CommentModel,
  CommentsCollection) ->

  class PostModel extends Backbone.JsonApiModel

    urlRoot: '/posts'
