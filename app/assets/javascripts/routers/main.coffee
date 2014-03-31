define ['backbone',
  'react',
  'ui/posts/wrap',
  'ui/posts/show',
  'collections/posts',
  'models/post'], (Backbone,
  React,
  PostsWrap,
  Post,
  PostsCollection,
  PostModel) ->

  class MainRouter extends Backbone.Router

    routes:
      "posts/:id"      : "posts_show"
      ""               : "posts_index"

    # actions
    posts_index: ->

      window.collection = new PostsCollection

      # render our UI component, passing in a collection
      React.unmountComponentAtNode(content)
      React.renderComponent(
        PostsWrap(
          posts: window.collection
        ),
        content
      )

    posts_show: (id) ->

      window.model = new PostModel.findOrCreate(id: id)

      # render our UI component, passing in a model
      React.unmountComponentAtNode(content)
      React.renderComponent(
        Post(
          post: window.model
          standalone: true
        ),
        content
      )

    # helper methods
    content:
      document.getElementById('content')


