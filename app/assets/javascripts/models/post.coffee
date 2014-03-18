(() ->

  Blog.Models.Post = Backbone.RelationalModel.extend

    urlRoot: '/posts'

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: 'Blog.Models.Comment'
      reverseRelation:
        key: 'post'
    ]

    defaults:
      title: null
      copy: null
      pub_date: null
      has_more_comments: false
      comments: []

)()
