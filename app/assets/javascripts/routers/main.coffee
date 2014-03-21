define ['backbone', 'react',
  'ui/posts', 'models/post'], (Backbone,
  React, PostsUI, PostModel) ->

  Backbone.Router.extend

    routes:
      "posts/new"      : "posts_new"
      "posts/:id/edit" : "posts_edit"
      "posts/:id"      : "posts_show"
      ""               : "posts_index"

    # actions
    posts_index: ->
      window.c = new Blog.Collections.Posts
      return
      # render our UI component, passing in a collection
      React.unmountComponentAtNode(content)
      React.renderComponent(
        Blog.Ui.PostsWrap(
          posts: new Blog.Collections.Posts
        ),
        content
      )

    posts_new: ->
      console.log "posts new"

    posts_show: (id) ->
      # render our UI component, passing in a collection and an id
      React.unmountComponentAtNode(content)
      React.renderComponent(
        PostsUI(
          post: PostModel.findOrCreate(id: id)
          standalone: true
        ),
        content
      )


    posts_edit: (id) ->
      console.log "posts edit #{id}"

    # helper methods
    content:
      document.getElementById('content')
