(() ->

  Blog.Collections.Posts = Backbone.Collection.extend 

    url: '/posts'

    model: Blog.Models.Post

)()
