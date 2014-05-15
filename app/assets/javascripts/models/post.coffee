define ['backbone'
  'models/comment'
  'models/author'
  'collections/comments'
  'lib/jsonapi-parser'], (Backbone
  CommentModel
  AuthorModel
  CommentsCollection
  JsonApiParser) ->

  class PostModel extends Backbone.RelationalModel

    urlRoot: '/posts'

    relations: [
      {
        type: Backbone.HasMany
        key: 'comments'
        relatedModel: CommentModel
        collectionType: CommentsCollection
        reverseRelation:
          key: 'post'
          includeInJSON: 'id'
      }
      {
        type: Backbone.HasOne
        key: 'author'
        relatedModel: CommentModel
      }
    ]

    parse: (response, options) ->
      new JsonApiParser(response, 'posts').parsedForModel()
