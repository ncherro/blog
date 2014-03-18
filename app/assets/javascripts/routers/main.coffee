(() ->

  Blog.Routers.Main = Backbone.Router.extend

    routes:
      "posts/new"      : "posts_new"
      "posts/:id/edit" : "posts_edit"
      "posts/:id"      : "posts_show"
      "posts"          : "posts_index"

    # actions
    posts_index: ->
      # render our UI component, passing in a collection
      React.renderComponent(
        (Blog.Ui.PostsWrap { collection: new Blog.Collections.Posts() }),
        document.getElementById('content')
      )

    posts_new: ->
      console.log "posts new"

    posts_show: (id) ->
      # render our UI component, passing in a collection and an id
      React.renderComponent(
        (Blog.Ui.Post { model: new Blog.Models.Post({ id: id }) }),
        document.getElementById('content')
      )

    posts_edit: (id) ->
      console.log "posts edit #{id}"

)()
