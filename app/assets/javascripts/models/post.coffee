(() ->

  Blog.Models.Post = Backbone.RelationalModel.extend

    urlRoot: '/posts'

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: Blog.Models.Comment
      collectionType: Blog.Collections.Comments
      reverseRelation:
        key: 'post'
        includeInJSON: 'id'
    ]

)()
