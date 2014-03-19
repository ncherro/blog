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

      # give the comments collection a reference to this model
      @comments.parent = @

      # trigger stuff when comments are updated
      @comments.bind 'reset', @updateCounts

)()
