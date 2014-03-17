(() ->
  D = React.DOM

  # Comments
  Blog.Ui.Comment = React.createClass
    render: ->
      D.div { className: 'comment' }, [
        D.p {}, @props.comment
        D.p {}, @props.created_at
      ]

  Blog.Ui.Comments = React.createClass
    render: ->
      D.div { className: 'comments' }, @props.data.map((comment) ->
        Blog.Ui.Comment(
          comment: comment.comment,
          created_at: comment.created_at_local
        )
      )

  Blog.Ui.CommentsWrap = React.createClass
    # our callbacks
    dataReceived: (data) ->
      @setState {
        comments: data.comments,
        has_more_comments: false,
      }

    # our event handlers
    showComments: (e) ->
      $.getJSON(@props.comments_url, @dataReceived)
      false

    # react
    getInitialState: ->
      {
        has_more_comments: @props.has_more_comments,
        comments: @props.comments,
      }

    render: ->
      if @state.has_more_comments
        more = (D.a { href: '#', onClick: @showComments }, 'More')
      else
        more = null
      D.div { className: 'comments' }, [
        D.h4 {}, 'Comments'
        Blog.Ui.Comments { data: @state.comments }
        more
      ]

)()
