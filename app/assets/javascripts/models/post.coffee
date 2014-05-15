define ['backbone'
        'models/comment'
        'models/author'
        'collections/comments'
        'lib/jsonapi-parser'
        'backbone.relational'], (Backbone
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
      console.log "PARSING", response
      new JsonApiParser(response, 'posts').parsedForModel()
