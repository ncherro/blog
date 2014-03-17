(() ->

  Blog.Models.Post = Backbone.RelationalModel.extend

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: 'Blog.Models.Comment'
    ]

    paramRoot: 'post'

    defaults:
      title: null
      copy: null
      pub_date: null

)()
