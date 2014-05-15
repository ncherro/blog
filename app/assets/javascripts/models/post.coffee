define ['backbone'
  'models/comment'
  'collections/comments'
  'lib/jsonapi-parser'], (Backbone
  CommentModel
  CommentsCollection
  JsonApiParser) ->

  class PostModel extends Backbone.Model

    urlRoot: '/posts'

    parse: (response, options) ->
      new JsonApiParser(response).parsedForModel()
