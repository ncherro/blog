(() ->

  Blog.Models.Post = Backbone.Model.extend

    urlRoot: '/posts'

    idAttribute: 'id'

    initialize: ->
      # set up our comments collection, passing in any pre-initialized data
      @comments = new Blog.Collections.Comments(@get('comments'))
      # pull comments from a custom nested route
      @comments.url = () =>
        "/posts/#{@id}/comments"
      @comments.bind 'reset', @updateCounts

)()
