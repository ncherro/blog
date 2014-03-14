$ ->

  D = React.DOM

  Post = React.createClass
    render: ->
      (D.div { className: 'post' }, [
        (D.h3 {}, @props.title),
        (D.p {}, @props.copy),
      ])

  PostList = React.createClass
    render: ->
      post = (post) ->
        Post { title: post.title, copy: post.copy }

      posts = @props.data.map(post)

      (D.div { className: 'post-list' }, posts)

  PostWrap = React.createClass
    getInitialState: ->
      loading: true,
      data: []

    componentWillMount: ->
      # set up the callback
      callback = (data) ->
        @setState {
          loading: false,
          data: data
        }

      # make the ajax call to our source
      $.getJSON(@props.source, callback.bind(@))

    componentDidMount: ->

    render: ->
      (D.div { className: 'hey' }, [
        (D.h1 {}, 'Posts'),
        PostList { data: @state.data }
      ])

  # start it up!
  React.renderComponent (PostWrap { source: '/posts.json' }), document.getElementById('content')
