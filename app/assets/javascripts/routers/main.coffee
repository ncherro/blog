define ['backbone'
        'react'
        'ui/posts/wrap'
        'ui/posts/show'
        'ui/posts/form'
        'collections/posts'
        'models/post'], (Backbone
        React
        PostsWrap
        Post
        PostForm
        PostsCollection
        PostModel) ->

  class MainRouter extends Backbone.Router

    routes:
      "posts/:id"      : "posts_show"
      ""               : "posts_index"

    # actions
    posts_index: ->
      posts = new PostsCollection
      # render our UI component, passing in a collection
      @unmountComponents()
      React.renderComponent(
        PostForm(
          posts: posts
        ),
        document.getElementById('form')
      )
      React.renderComponent(
        PostsWrap(
          posts: posts
        ),
        document.getElementById('content')
      )

    posts_show: (id) ->
      # render our UI component, passing in a model
      # NOTE: this is breaking - not sure why
      post = new PostModel.findOrCreate(id: id)
      @unmountComponents()
      React.renderComponent(
        Post(
          post: post
          standalone: true
        ),
        document.getElementById('content')
      )

    # 'helper' methods
    unmountComponents: ->
      React.unmountComponentAtNode(document.getElementById('content'))
      if document.getElementById('form')
        React.unmountComponentAtNode(document.getElementById('form'))
