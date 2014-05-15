define ['backbone'
  'models/post'
  'backbone.jsonapi'], (Backbone
  PostModel) ->

  class PostsCollection extends Backbone.JsonApiCollection

    model: PostModel

    url: '/posts'

    comparator: (post) ->
      -post.get('created_at')
