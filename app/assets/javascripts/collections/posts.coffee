define ['backbone',
  'models/post'], (Backbone,
  PostModel) ->

  class PostsCollection extends Backbone.Collection

    model: PostModel

    url: '/posts'

    # custom properties used for pagination
    current_page: 1
    total_pages: 1
    total_count: 1

    comparator: (post) ->
      -post.get('created_at')

    parse: (response) ->
      @current_page = response.meta.current_page
      @total_pages = response.meta.total_pages
      @total_count = response.meta.total_count
      response.posts
