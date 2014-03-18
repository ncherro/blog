(() ->
  D = React.DOM
  converter = new Showdown.converter

  # Posts
  Blog.Ui.Post = React.createClass
    render: ->
      # NOTE: @props.post is a Backbone model, use it accordingly
      D.div { className: 'post' }, [
        D.h3 {}, @props.post.get('title')
        D.p {}, @props.post.get('pub_date_local')
        D.div { dangerouslySetInnerHTML: { __html: converter.makeHtml(@props.post.get('copy')) }}
        Blog.Ui.CommentsWrap
          comments: @props.post.get('comments'),
          has_more_comments: @props.post.get('has_more_comments'),
          comments_url: @props.post.get('comments_url'),
          source: false,
        D.hr {}
      ]

  Blog.Ui.Posts = React.createClass
    render: ->
      renderPost = (post) ->
        Blog.Ui.Post { post: post }
      (D.div { className: 'posts' }, @props.data.map(renderPost))

  Blog.Ui.PostsWrap = React.createClass
    # react-backbone
    mixins: [Blog.BackboneMixins]

    getBackboneCollections: () ->
      [@props.posts]

    # react
    getInitialState: ->
      loading: true
      current_page: 1
      total_pages: 1
      posts: []

    componentDidMount: ->

      console.log 'Blog.Ui.PostsWrap.componentDidMount'

      Router = Backbone.Router.extend
        routes:
          '': 'all'
        all: @setState.bind(@, { loading: true })

      new Router()

      Backbone.history.start()

      @props.posts.fetch(
        data: { page: @state.current_page }
      )

    render: ->

      console.log('Blog.Ui.PostsWrap.render')

      # NOTE: this gets hit after the posts are loaded

      D.div {}, [
        D.h1 {}, "Posts - #{@state.current_page} of #{@state.total_pages}"
        Blog.Ui.Posts { data: @props.posts }
      ]

)()
