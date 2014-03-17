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

        console.log 'rendering post', post

        Blog.Ui.Post { post: post }

      console.log 'Posts props.data', @props.data

      (D.div { className: 'posts' }, @props.data.map(renderPost))

  Blog.Ui.PostsWrap = React.createClass

    # react-backbone
    mixins: [Blog.BackboneMixins]

    getBackboneCollections: () ->
      @state.posts

    # react
    getInitialState: ->
      loading: true
      current_page: 1
      total_pages: 1
      posts: []

    componentWillMount: ->
      success = (collection) ->
        @setState
          loading: false
          posts: collection
      @props.posts.fetch(
        data: { page: @state.current_page }
        success: success.bind(@)
      )

    render: ->
      console.log 'render PostsWrap'
      D.div {}, [
        D.h1 {}, "Posts - #{@state.current_page} of #{@state.total_pages}"
        Blog.Ui.Posts { data: @state.posts }
      ]

)()
