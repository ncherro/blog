(() ->
  D = React.DOM

  # Comments
  Blog.Ui.CommentForm = React.createClass
    # event handlers
    handleChange: (e) ->
      @setState
        content: e.target.value

    handleSubmit: (e) ->
      e.preventDefault()
      @props.comments.create(content: @state.content, {
        wait: true
        success: (collection, model) =>
          @setState
            content: ''
            errors: []
            message: 'Your comment has been saved!'

        error: (collection, response) =>
          errors = response.responseJSON
          r = []
          _.map errors, (errors_a, key) ->
            _.map errors_a, (error) ->
              r.push("#{key} #{error}")
          @setState
            errors: r
            message: ''
      })

    # react
    getInitialState: ->
      content: ''
      errors: []
      message: ''

    render: ->
      D.form { onSubmit: @handleSubmit }, [
        D.h3 {}, 'New Comment'
        if @state.message
          D.h4 {}, @state.message
        if @state.errors.length
          [
            (D.h4 {}, "#{@state.errors.length} error(s) prevented your comment from being saved:"),
            D.ul {}, _.map @state.errors, (error_str) ->
              D.li {}, error_str
          ]
        D.input {
          type: 'text'
          onChange: @handleChange
          placeholder: 'Comment'
          value: @state.content
        }
        D.button { type: 'submit' }, 'Submit'
      ]


  Blog.Ui.Comment = React.createClass
    render: ->
      D.div { className: 'comment' }, [
        D.p {}, "##{@props.comment.get('id')} - #{@props.comment.get('content')}"
        D.p {}, @props.comment.get('created_at')
      ]


  Blog.Ui.Comments = React.createClass
    # loop through and render comments (load: false b/c they are loaded)
    render: ->
      D.div { className: 'comments' }, @props.comments.map (comment) ->
        Blog.Ui.Comment { comment: comment, load: false }


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
          Blog.Ui.Comments comments: @props.comments
          if @state.loading
            Blog.Ui.Loading text: 'Loading comments...'
          else if @props.comments_count > @props.comments.length
            D.a {href: '#', onClick: @loadMore }, "Load more"
        ]
        D.hr {}
        Blog.Ui.CommentForm
          comments: @props.comments
      ]

)()
