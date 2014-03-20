(() ->
  D = React.DOM
  converter = new Showdown.converter

  # Posts
  Blog.Ui.Post = React.createClass
    # event handlers
    handleChanged: (model, resp, options) ->
      @setState
        loading: false

    # react
    getInitialState: ->
      loading: true

    componentWillUnmount: ->
      # unbind all event listeners in @ context
      @props.model.off null, null, @

    componentWillMount: ->
      load = typeof @props.load == 'undefined' ? true : @props.load
      @setState
        loading: load
      # update our state when the model changes
      @props.model.on 'change', @handleChanged, @
      @props.model.fetch() if load

    render: ->
      if @state.loading
        Blog.Ui.Loading()
      else
        attrs = { className: 'post' }
        attrs['id'] = 'posts-wrap' if @props.standalone
        D.div attrs, [
          D.h3 {}, [
            D.a { href: @props.model.get('url'), onClick: (e) ->
              e.preventDefault()
              new Blog.Routers.Main().navigate($(e.target).attr('href'), true)
            }, @props.model.get('title')
          ]
          D.p {}, @props.model.get('pub_date_local')
          D.div { dangerouslySetInnerHTML: {
            __html: converter.makeHtml(@props.model.get('copy'))
          }}
          Blog.Ui.CommentsWrap
            collection: @props.model.comments,
            new_model: new @props.model.comments.model(post_id: @props.model.get('id'))
          D.hr {}
        ]


  Blog.Ui.Posts = React.createClass
    # loop through and render posts (load: false b/c they are loaded)
    render: ->
      D.div { className: 'posts' }, @props.collection.map (post) ->
        Blog.Ui.Post { model: post, load: false }


  Blog.Ui.PostsWrap = React.createClass
    # event handlers
    handleUpdated: (e, collection, options) ->
      @setState
        loading: false

    nextPage: (e) ->
      e.preventDefault()
      @loadMore(@props.collection.current_page + 1)

    # custom methods
    loadMore: (p) ->
      p = p || @props.collection.current_page
      @setState
        loading: true
      # fetch, appending to the collection
      @props.collection.fetch
        remove: false
        data: { page: p }

    # react
    getInitialState: ->
      loading: true

    componentWillUnmount: ->
      $(window).off 'scroll.posts'
      # unbind all event listeners in @ context
      @props.collection.off null, null, @

    componentWillMount: ->
      # update our state when the collection changes
      @props.collection.on 'add remove reset', @handleUpdated, @

      # load more when we hit the bottom of the page
      $(window).on 'scroll.posts', =>
        if !@state.loading && (@props.collection.current_page != @props.collection.total_pages) &&
          $(window).scrollTop() + $(window).height() == $(document).height()
            @setState
              loading: true
            setTimeout(() =>
              @loadMore(@props.collection.current_page + 1)
            , 600)

      # fetch
      @loadMore()

    render: ->
      D.div {}, [
        D.div { id: 'info' }, [
          if @props.collection.length
            D.h1 {}, "Showing 1 - #{@props.collection.length} of #{@props.collection.total_count} Posts"
        ]
        D.div { id: 'posts-wrap' }, [
          Blog.Ui.Posts { collection: @props.collection }
          if @state.loading
            Blog.Ui.Loading()
          else if @props.collection.current_page != @props.collection.total_pages
            D.a {href: '#', onClick: @nextPage }, "Load more"
        ]
      ]

)()
