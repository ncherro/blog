(() ->
  D = React.DOM

  # Comments
  Blog.Ui.Comment = React.createClass
    render: ->
      D.div { className: 'comment' }, [
        D.p {}, @props.model.get('comment')
        D.p {}, @props.model.get('created_at')
        D.hr {}
      ]


  Blog.Ui.Comments = React.createClass
    # loop through and render comments (load: false b/c they are loaded)
    render: ->
      D.div { className: 'comments' }, @props.collection.map (comment) ->
        Blog.Ui.Comment { model: comment, load: false }


  Blog.Ui.CommentsWrap = React.createClass
    # event callbacks
    handleUpdated: (e, collection, options) ->
      console.log 'yip'

    nextPage: (e) ->
      e.preventDefault()
      @loadMore(@state.current_page + 1)

    # custom methods
    loadMore: (p) ->
      p = p || @state.current_page
      @setState
        loading: true
      # fetch, appending to the collection
      @props.collection.fetch
        remove: false
        data: { page: p }


    # react
    getInitialState: ->
      loading: true
      current_page: 1
      total_pages: 1
      current_count: 1
      total_count: 1

    componentWillUnmount: ->
      # unbind all event listeners in @ context
      @props.collection.off null, null, @

    componentWillMount: ->
      if !@props.collection.isEmpty()
        @setState
          loading: false

      # update our state when the collection changes
      @props.collection.on 'add remove change', @handleUpdated, @

    render: ->
      if @state.loading
        Blog.Ui.Loading()
      else
        D.div {}, [
          Blog.Ui.Comments { collection: @props.collection }
          if @state.current_page != @state.total_pages
            D.a {href: '#', onClick: @nextPage }, "Load more"
        ]

)()
