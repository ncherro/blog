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
    render: ->
      D.h4 {}, 'hi'

)()
