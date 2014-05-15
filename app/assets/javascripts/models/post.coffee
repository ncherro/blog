define ['backbone'
  'models/comment'
  'collections/comments'
  'lib/jsonapi-parser'], (Backbone
  CommentModel
  CommentsCollection
  JsonApiParser) ->

  class PostModel extends Backbone.RelationalModel

    urlRoot: '/posts'

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: CommentModel
      collectionType: CommentsCollection
      reverseRelation:
        key: 'post'
        includeInJSON: 'id'
    ]

    parse: (response, options) ->
      new JsonApiParser(response, 'posts').parsedForModel()
