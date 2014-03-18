(() ->
  D = React.DOM
  converter = new Showdown.converter

  # Posts
  Blog.Ui.Post = React.createClass

    getInitialState: ->
      loading: false

    componentWillMount: ->
      if typeof @props.post == 'undefined'
        # we are coming directly from backbone - look it up...
        @setState
          loading: true

        success = (model, response, options) ->
          @setProps
            post: model
          @setState
            loading: false

        @props.model.fetch
          success: success.bind(@)

    render: ->
      if @state.loading
        Blog.Ui.Loading()
      else
        # @props.post is a Backbone model
        D.div { className: 'post' }, [
          D.h3 {}, [
            D.a { href: @props.post.get('url'), onClick: (e) ->
              e.preventDefault()
              new Blog.Routers.Main().navigate($(e.target).attr('href'), true)
            }, @props.post.get('title')
          ]
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
    # loop through and render posts
    render: ->

      renderPost = (post) ->
        Blog.Ui.Post { post: post }

      D.div { className: 'posts' }, @props.collection.map(renderPost)


  Blog.Ui.PostsWrap = React.createClass
    # react-backbone
    mixins: [Blog.BackboneMixins]

    getBackboneCollections: ->
      [@props.collection]

    # event handlers
    nextPage: (e) ->
      e.preventDefault()
      @loadMore(@state.current_page + 1)

    # custom methods
    loadMore: (p) ->
      success = (collection, response, options) ->
        @setState
          loading: false
          current_page: collection.current_page
          total_pages: collection.total_pages
          current_count: collection.length
          total_count: collection.total_count

      p = p || @state.current_page

      @setState
        loading: true

      @props.collection.fetch
        remove: false # ensure things are only added
        data: { page: p },
        success: success.bind(@)

    # react
    getInitialState: ->
      loading: true
      current_page: 1
      total_pages: 1
      current_count: 1
      total_count: 1
      collection: []

    componentDidMount: ->
      @loadMore()

    render: ->
      D.div {}, [
        D.h1 {}, "Showing 1 - #{@state.current_count} of #{@state.total_count} Posts"
        Blog.Ui.Posts { collection: @props.collection }
        if @state.loading
          Blog.Ui.Loading()
        else if @state.current_page != @state.total_pages
          D.a {href: '#', onClick: @nextPage}, "Load more"
      ]

)()
