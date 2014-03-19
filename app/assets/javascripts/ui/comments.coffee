(() ->
  D = React.DOM

  # Comments
  Blog.Ui.Comment = React.createClass
    render: ->
      D.div { className: 'comment' }, [
        D.p {}, @props.model.get('comment')
        D.p {}, @props.model.get('created_at')
      ]


  Blog.Ui.Comments = React.createClass
    # loop through and render comments (load: false b/c they are loaded)
    render: ->
      D.div { className: 'comments' }, @props.collection.map (comment) ->
        Blog.Ui.Comment { model: comment, load: false }


  Blog.Ui.CommentsWrap = React.createClass
    # event callbacks
    handleUpdated: (e, collection, options) ->
      @setState
        loading: false
        loaded_all: true

    # custom methods
    loadMore: (e) ->
      e.preventDefault()
      @setState
        loading: true

      # fetch, appending to the collection
      @props.collection.fetch
        remove: false


    # react
    getInitialState: ->
      loading: true
      loaded_all: false

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
        Blog.Ui.Loading text: 'Loading comments...'
      else
        D.div {}, [
          D.h4 {}, 'Comments'
          Blog.Ui.Comments { collection: @props.collection }
          if !@state.loaded_all && @props.collection.parent.get('has_more_comments')
            D.a {href: '#', onClick: @loadMore }, "Load more"
        ]

)()
