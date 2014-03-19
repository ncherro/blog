(() ->

  Blog.Routers.Main = Backbone.Router.extend

    routes:
      "posts/new"      : "posts_new"
      "posts/:id/edit" : "posts_edit"
      "posts/:id"      : "posts_show"
      ""               : "posts_index"

    # actions
    posts_index: ->
      # render our UI component, passing in a collection
      React.unmountComponentAtNode(content)
      React.renderComponent(
        (Blog.Ui.PostsWrap { collection: new Blog.Collections.Posts() }),
        content
      )

    posts_new: ->
      console.log "posts new"

    posts_show: (id) ->
      # render our UI component, passing in a collection and an id
      React.unmountComponentAtNode(content)
      React.renderComponent(
        (Blog.Ui.Post {
          model: Blog.Models.Post.findOrCreate({ id: id }),
          standalone: true,
        }),
        content
      )

    posts_edit: (id) ->
      console.log "posts edit #{id}"

    # helper methods
    content:
      document.getElementById('content')

)()
