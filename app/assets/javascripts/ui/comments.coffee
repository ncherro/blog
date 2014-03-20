(() ->
  D = React.DOM

  # Comments
  Blog.Ui.Comment = React.createClass
    render: ->
      D.div { className: 'comment' }, [
        D.p {}, "##{@props.model.get('id')} - #{@props.model.get('content')}"
        D.p {}, @props.model.get('created_at')
      ]


  Blog.Ui.Comments = React.createClass
    # loop through and render comments (load: false b/c they are loaded)
    render: ->
      D.div { className: 'comments' }, @props.collection.map (comment) ->
        Blog.Ui.Comment { model: comment, load: false }


  Blog.Ui.CommentForm = React.createClass
    # event handlers
    handleChange: (e) ->
      @setState
        content: e.target.value

    handleSubmit: (e) ->
      e.preventDefault()
      # we have a boilerplate model passed in - clone it, saving the new content
      @props.model.clone().save(
        { content: @state.content },
        success: (model, status, jqXHR) =>
          @props.collection.add(model)
          @setState
            content: ''
        )

    # react
    getInitialState: ->
      content: ''

    render: ->
      D.form { onSubmit: @handleSubmit }, [
        D.h3 {}, 'New Comment'
        D.input {
          type: 'text'
          onChange: @handleChange
          placeholder: 'Comment'
          value: @state.content
        }
        D.button { type: 'submit' }, 'Submit'
      ]

  Blog.Ui.CommentsWrap = React.createClass
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
      @props.collection.fetch
        remove: false

    # react
    getInitialState: ->
      loading: true

    componentWillUnmount: ->
      # unbind all event listeners in @ context
      @props.collection.off null, null, @

    componentWillMount: ->
      # update our state when the collection changes
      @props.collection.on 'add remove change', @handleUpdated, @

      if @props.collection.isEmpty()
        @loadMore()
      else
        @setState
          loading: false

    render: ->
      D.div {}, [
        D.div {}, [
          D.h4 {}, 'Comments'
          Blog.Ui.Comments collection: @props.collection
          if @state.loading
            Blog.Ui.Loading text: 'Loading comments...'
          else if @props.collection.total_count > @props.collection.length
            D.a {href: '#', onClick: @loadMore }, "Load more"
        ]
        D.hr {}
        Blog.Ui.CommentForm
          model: @props.new_model,
          collection: @props.collection
      ]

)()
