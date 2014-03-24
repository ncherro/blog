define ['react'], (React) ->

  D = React.DOM

  React.createClass
    render: ->
      D.div { className: 'comment' }, [
        D.p {}, "##{@props.comment.get('id')} - #{@props.comment.get('content')}"
        D.p {}, @props.comment.get('created_at')
      ]
