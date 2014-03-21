(() ->
  D = React.DOM
  converter = new Showdown.converter

  # Posts
  Blog.Ui.Post = React.createClass
    # event handlers
    handleChanged: (model, options) ->
      @setState
        loading: false

    # react
    getInitialState: ->
      loading: true

    componentWillUnmount: ->
      # unbind all event listeners in @ context
      @props.post.off null, null, @

    componentWillMount: ->
      load = typeof @props.load == 'undefined' ? true : @props.load
      @setState
        loading: load
      # update our state when the model changes
      @props.post.on 'change', @handleChanged, @
      @props.post.fetch() if load

    render: ->
      if @state.loading
        Blog.Ui.Loading()
      else
        attrs = { className: 'post' }
        attrs['id'] = 'posts-wrap' if @props.standalone
        D.div attrs, [
          D.h3 {}, [
            D.a { href: @props.post.get('url'), onClick: (e) ->
              e.preventDefault()
              new Blog.Routers.Main().navigate($(e.target).attr('href'), true)
            }, @props.post.get('title')
          ]
          D.p {}, @props.post.get('pub_date_local')
          D.div { dangerouslySetInnerHTML: {
            __html: converter.makeHtml(@props.post.get('copy'))
          }}
          Blog.Ui.CommentsWrap
            comments: @props.post.get('comments')
          D.hr {}
        ]


  Blog.Ui.Posts = React.createClass
    # loop through and render posts (load: false b/c they are loaded)
    render: ->
      D.div { className: 'posts' }, @props.posts.map (post) ->
        Blog.Ui.Post { post: post, load: false }


  Blog.Ui.PostsWrap = React.createClass
    # event handlers
    handleUpdated: (e, collection, options) ->
      @setState
        loading: false

    nextPage: (e) ->
      e.preventDefault()
      @loadMore(@props.posts.current_page + 1)

    # custom methods
    loadMore: (p) ->
      p = p || @props.posts.current_page
      @setState
        loading: true
      # fetch, appending to the collection
      @props.posts.fetch
        remove: false
        data: { page: p }

    # react
    getInitialState: ->
      loading: true

    componentWillUnmount: ->
      $(window).off 'scroll.posts'
      # unbind all event listeners with @ context
      @props.posts.off null, null, @

    componentWillMount: ->
      # update our state when the collection changes
      @props.posts.on 'add remove reset', @handleUpdated, @

      # load more when we hit the bottom of the page
      $(window).on 'scroll.posts', =>
        if !@state.loading && (@props.posts.current_page != @props.posts.total_pages) &&
          $(window).scrollTop() + $(window).height() == $(document).height()
            @setState
              loading: true
            setTimeout(() =>
              @loadMore(@props.posts.current_page + 1)
            , 600)

      # fetch
      @loadMore()

    render: ->
      D.div {}, [
        D.div { id: 'info' }, [
          if @props.posts.length
            D.h1 {}, "Showing 1 - #{@props.posts.length} of #{@props.posts.total_count} Posts"
        ]
        D.div { id: 'posts-wrap' }, [
          Blog.Ui.Posts { posts: @props.posts }
          if @state.loading
            Blog.Ui.Loading()
          else if @props.posts.current_page != @props.posts.total_pages
            D.a {href: '#', onClick: @nextPage }, "Load more"
        ]
      ]

)()
