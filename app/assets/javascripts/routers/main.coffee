(() ->

  Blog.Routers.Main = Backbone.Router.extend

    routes:
      "posts/new"      : "posts_new"
      "posts/:id/edit" : "posts_edit"
      "posts/:id"      : "posts_show"
      "posts"          : "posts_index"

    posts_index: ->
      React.renderComponent(
        (Blog.Ui.PostsWrap { posts: new Blog.Collections.Posts() }),
        document.getElementById('content')
      )

    posts_new: ->
      console.log "posts new"

    posts_show: (id) ->
      console.log "posts show #{id}"

    posts_edit: (id) ->
      console.log "posts edit #{id}"

)()
