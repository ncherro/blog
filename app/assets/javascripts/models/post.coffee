(() ->

  Blog.Models.Post = Backbone.RelationalModel.extend

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: 'Blog.Models.Comment'
    ]

    defaults:
      title: null
      copy: null
      pub_date: null

)()
