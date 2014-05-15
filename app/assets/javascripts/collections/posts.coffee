define ['backbone'
  'models/post'
  'lib/jsonapi-parser'], (Backbone
  PostModel
  JsonApiParser) ->

  class PostsCollection extends Backbone.Collection

    model: PostModel

    url: '/posts'

    comparator: (post) ->
      -post.get('created_at')

    parse: (response, options) ->
      new JsonApiParser(response).parsedForCollection()
