(() ->

  Blog.Collections.Comments = Backbone.Collection.extend

    model: Blog.Models.Comment

    # custom properties
    parent: null
    total_count: 0

    parse: (response) ->
      @total_count = response.meta.total_count
      response.comments

)()
