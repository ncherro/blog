define ['react',
  'ui/posts/show'], (React,
  Post) ->

  D = React.DOM

  React.createClass
    # loop through and render posts (load: false b/c they are loaded)
    render: ->
      D.div { className: 'posts' }, @props.posts.map (post) ->
        Post ( post: post, load: false )
