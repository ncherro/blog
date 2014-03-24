define ['react',
  'ui/comments/show'], (React,
  Comment) ->

  D = React.DOM

  React.createClass
    # loop through and render comments (load: false b/c they are loaded)
    render: ->
      D.div { className: 'comments' }, @props.comments.map (comment) ->
        Comment { comment: comment, load: false }
