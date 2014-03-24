define ['backbone',
  'models/comment',
  'collections/comments',
  'backbone.relational'], (Backbone,
  CommentModel,
  CommentsCollection) ->

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
