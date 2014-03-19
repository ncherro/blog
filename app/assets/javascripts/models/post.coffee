(() ->

  Blog.Models.Post = Backbone.RelationalModel.extend

    urlRoot: '/posts'

    idAttribute: 'id'

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: 'Blog.Models.Comment'
      reverseRelation:
        key: 'post'
        includeInJSON: 'id'
    ]

)()
