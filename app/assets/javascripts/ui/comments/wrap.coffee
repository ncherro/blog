define ['react',
  'ui/common/loading',
  'ui/comments/index',
  'ui/comments/form'], (React,
  Loading,
  Comments,
  CommentForm) ->

  D = React.DOM

  React.createClass
    # event handlers
    handleUpdated: (e, collection, options) ->
      @setState
        loading: false

    # custom methods
    loadMore: (e) ->
      e.preventDefault() if e
      @setState
        loading: true

      # fetch all(!) related comments, appending new ones to the collection
      @props.comments.fetch
        remove: false

    # react
    getInitialState: ->
      loading: true

    componentWillUnmount: ->
      # unbind all event listeners in @ context
      @props.comments.off null, null, @

    componentWillMount: ->
      # update our state when the collection changes
      @props.comments.on 'add remove reset', @handleUpdated, @

      if @props.comments.isEmpty()
        @loadMore()
      else
        @setState
          loading: false

    render: ->
      D.div {}, [
        D.div {}, [
          D.h4 {}, 'Comments'
          Comments comments: @props.comments
          if @state.loading
            Loading text: 'Loading comments...'
          else if @props.comments_count > @props.comments.length
            D.a {href: '#', onClick: @loadMore }, "Load more"
        ]
        D.hr {}
        CommentForm
          comments: @props.comments
      ]
