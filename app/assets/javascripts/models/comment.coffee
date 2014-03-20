(() ->

  Blog.Models.Comment = Backbone.Model.extend

    urlRoot: '/comments'

    paramRoot: 'comment'

    idAttribute: 'id'

)()
