(() ->

  Blog.Collections.Comments = Backbone.Collection.extend

    model: Blog.Models.Comment

    # custom properties
    current_page: 1
    total_pages: 1
    total_count: 1

    parse: (response) ->
      @current_page = response.meta.current_page
      @total_pages = response.meta.total_pages
      @total_count = response.meta.total_count
      response.comments

)()
