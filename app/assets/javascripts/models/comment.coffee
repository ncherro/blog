(() ->

  Blog.Models.Comment = Backbone.RelationalModel.extend

    urlRoot: '/comments'

    idAttribute: 'id'

)()
