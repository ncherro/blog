define ['react',
  'jquery',
  'ui/common/loading',
  'ui/posts/index'], (React,
  $,
  Loading,
  Posts) ->

  D = React.DOM

  React.createClass
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
          Posts { posts: @props.posts }
          if @state.loading
            Loading()
          else if @props.posts.current_page != @props.posts.total_pages
            D.a {href: '#', onClick: @nextPage }, "Load more"
        ]
      ]

