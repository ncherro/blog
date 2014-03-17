(() ->

  Blog.Collections.Posts = Backbone.Collection.extend 

    url: '/posts.json'

    model: Blog.Models.Post

)()
