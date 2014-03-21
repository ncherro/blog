(() ->

  Blog.Models.Comment = Backbone.RelationalModel.extend

    urlRoot: ->
      post = @get('post') or @collection.post
      "/posts/#{post.id}/comments"

)()
