(() ->

  Blog.Collections.Comments = Backbone.Collection.extend

    model: Blog.Models.Comment

    # custom properties
    parent: null

    parse: (response) ->
      @current_page = response.meta.current_page
      @total_pages = response.meta.total_pages
      @total_count = response.meta.total_count
      response.comments

)()
