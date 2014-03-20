(() ->

  Blog.Models.Post = Backbone.Model.extend

    urlRoot: '/posts'

    idAttribute: 'id'

    initialize: ->
      # set up our comments collection
      @comments = new Blog.Collections.Comments(@get('comments'))
      # give the comments collection a reference to `this`
      @comments.parent = @
      @comments.total_count = @get('comments_count')

      # pull comments from our custom nested route
      @comments.url = () =>
        "/posts/#{@id}/comments"

)()
