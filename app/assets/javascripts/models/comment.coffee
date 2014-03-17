(() ->

  Blog.Models.Comment = Backbone.RelationalModel.extend

    urlRoot: '/comment/'

    defaults:
      comment: ''

)()
