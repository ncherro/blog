(() ->

  Blog.Models.Post = Backbone.RelationalModel.extend

    model: Blog.Models.Post

    urlRoot: '/posts'

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: Blog.Models.Comment
      reverseRelation:
        key: 'post'
        includeInJSON: 'id'
    ]

)()
