define ['backbone'
  'models/post'
  'lib/jsonapi-parser'
  'backbone.relational'], (Backbone
  PostModel
  JsonApiParser) ->

  class PostsCollection extends Backbone.Collection

    model: PostModel

    url: '/posts'

    # instance vars used for pagination
    current_page: 1
    total_pages: 1
    total_count: 1

    comparator: (post) ->
      -post.get('pub_date')

    parse: (response, options) ->
      @current_page = response.meta.current_page
      @total_pages = response.meta.total_pages
      @total_count = response.meta.total_count
      new JsonApiParser(response, 'posts').parsedForCollection()
