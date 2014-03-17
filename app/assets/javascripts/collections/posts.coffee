(() ->

  Blog.Collections.Posts = Backbone.Collection.extend

    model: Blog.Models.Post

    url: '/posts'

    loadedAll: false

    parse: (response) ->
      @loadedAll = response.posts.length == 0
      response.posts

)()
