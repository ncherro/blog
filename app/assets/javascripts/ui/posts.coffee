(() ->
  D = React.DOM
  converter = new Showdown.converter

  # Posts
  Blog.Ui.Post = React.createClass
    render: ->
      D.div { className: 'post' }, [
        D.h3 {}, @props.post.title
        D.p {}, @props.post.pub_date_local
        D.div { dangerouslySetInnerHTML: { __html: converter.makeHtml(@props.post.copy) }}
        Blog.Ui.CommentsWrap
          comments: @props.post.comments,
          has_more_comments: @props.post.has_more_comments,
          comments_url: @props.post.comments_url,
          source: false,
        D.hr {}
      ]

  Blog.Ui.Posts = React.createClass
    render: ->
      renderPost = (post) ->
        Blog.Ui.Post { post: post }

      (D.div { className: 'posts' }, @props.data.map(renderPost))

  Blog.Ui.PostsWrap = React.createClass
    # our callbacks
    ###
    dataReceived: (data) ->
      @setState {
        loading: false,
        current_page: data.meta.current_page,
        total_pages: data.meta.total_pages,
        posts: data.posts
      }

    # our event handlers
    firstPage: (e) ->
      e.preventDefault
      $.getJSON(@props.source + '?page=1', @dataReceived)

    prevPage: (e) ->
      e.preventDefault
      page = @state.current_page - 1
      return if page < 1
      $.getJSON(@props.source + '?page=' + page, @dataReceived)

    nextPage: (e) ->
      e.preventDefault
      page = @state.current_page + 1
      return if page > @state.total_pages
      $.getJSON(@props.source + '?page=' + page, @dataReceived)

    lastPage: (e) ->
      e.preventDefault
      $.getJSON(@props.source + '?page=' + @state.total_pages, @dataReceived)
    ###

    # react-backbone stuff
    mixins: [Blog.BackboneMixins]

    getBackboneCollections: () ->
      [@props.posts]

    # react stuff
    getInitialState: ->
      loading: true
      current_page: 1
      total_pages: 1
      posts: []

    componentWillMount: ->
      Blog.Routers.Posts = Backbone.Router.extend(
        routes:
          '': 'all'
        # all ^ will call this function
        all: @setState.bind(@, {
          loading: false
          current_page: 1
          total_pages: 1
        })
      )

      console.log Blog.Routers.Posts.routes

      new Blog.Routers.Posts

      Backbone.history.start
        pushState: true

      # @props.posts is a Backbone collection
      do @props.posts.fetch

    render: ->
      D.div {}, [
        D.h1 {}, "Posts - #{@state.current_page} of #{@state.total_pages}"
        Blog.Ui.Posts { data: @state.posts }
      ]

)()
