(() ->

  Blog.Models.Comment = Backbone.Model.extend

    urlRoot: '/comment/'

    defaults:
      comment: ''

)()
