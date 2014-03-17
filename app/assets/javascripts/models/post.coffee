(() ->

  Blog.Models.Post = Backbone.RelationalModel.extend

    relations: [
      type: Backbone.HasMany
      key: 'comments'
      relatedModel: 'Blog.Models.Comment'
    ]

    urlRoot: '/post/'

    defaults:
      title: ''
      copy: ''
      pub_date: new Date

    toggle: () ->
      @save
        completed: !@get('completed')

)()
