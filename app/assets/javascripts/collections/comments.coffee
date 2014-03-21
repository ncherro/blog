(() ->

  class Blog.Collections.Comments extends Backbone.Collection

    model: Blog.Models.Comment

    url: ->
      post = post || @post
      "/posts/#{@post.id}/comments"

    parse: (response) ->
      if response.meta.total_count
        @total_count = response.meta.total_count
      response.comments

)()
