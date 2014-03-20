(() ->

  Blog.Models.Comment = Backbone.Model.extend

    urlRoot: '/comments'

    idAttribute: 'id'

)()
