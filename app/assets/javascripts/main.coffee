D = React.DOM

converter = new Showdown.converter


# Comments
Comment = React.createClass
  render: ->
    (D.div { className: 'comment' }, [
      (D.p {}, @props.comment),
      (D.p {}, @props.created_at),
    ])

Comments = React.createClass
  render: ->
    D.div { className: 'comments' }, @props.data.map((comment) ->
      Comment(
        comment: comment.comment,
        created_at: comment.created_at_local
      )
    )

CommentsWrap = React.createClass
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
    console.log @props
    if @state.has_more_comments
      more = (D.a { href: '#', onClick: @showComments }, 'More')
    else
      more = null
    D.div { className: 'comments' }, [
      D.h4 {}, 'Comments'
      Comments { data: @state.comments }
      more
    ]



# Posts
Post = React.createClass
  render: ->
    (D.div { className: 'post' }, [
      (D.h3 {}, @props.post.title),
      (D.p {}, @props.post.pub_date_local),
      (D.div { dangerouslySetInnerHTML: { __html: converter.makeHtml(@props.post.copy) }}),
      (CommentsWrap {
        comments: @props.post.comments,
        has_more_comments: @props.post.has_more_comments,
        comments_url: @props.post.comments_url,
        source: false,
      }),
      (D.hr {})
    ])

Posts = React.createClass
  render: ->
    renderPost = (post) ->
      Post { post: post }

    (D.div { className: 'posts' }, @props.data.map(renderPost))

PostsWrap = React.createClass
  # our callbacks
  dataReceived: (data) ->
    @setState {
      loading: false,
      current_page: data.meta.current_page,
      total_pages: data.meta.total_pages,
      posts: data.posts
    }

  # our event handlers
  firstPage: (e) ->
    e.preventDefault
    $.getJSON(@props.source + '?page=1', @dataReceived)

  prevPage: (e) ->
    e.preventDefault
    page = @state.current_page - 1
    return if page < 1
    $.getJSON(@props.source + '?page=' + page, @dataReceived)

  nextPage: (e) ->
    e.preventDefault
    page = @state.current_page + 1
    return if page > @state.total_pages
    $.getJSON(@props.source + '?page=' + page, @dataReceived)

  lastPage: (e) ->
    e.preventDefault
    $.getJSON(@props.source + '?page=' + @state.total_pages, @dataReceived)


  # react stuff
  getInitialState: ->
    loading: true,
    current_page: 1,
    total_pages: 1,
    posts: []

  componentWillMount: ->
    # make the ajax call to our source
    $.getJSON(@props.source + '?page=' + @state.current_page, @dataReceived)

  render: ->
    (D.div {}, [
      (D.h1 {}, "Posts - #{@state.current_page} of #{@state.total_pages}"),
      (D.p { className: 'pagination' }, [
        (D.a { onClick: @firstPage, href: '#' }, 'First'),
        (D.a { onClick: @prevPage, href: '#' }, 'Prev'),
        (D.a { onClick: @nextPage, href: '#' }, 'Next'),
        (D.a { onClick: @lastPage, href: '#' }, 'Last'),
      ])
      (Posts { data: @state.posts }),
      (D.p { className: 'pagination' }, [
        (D.a { onClick: @firstPage, href: '#' }, 'First'),
        (D.a { onClick: @prevPage, href: '#' }, 'Prev'),
        (D.a { onClick: @nextPage, href: '#' }, 'Next'),
        (D.a { onClick: @lastPage, href: '#' }, 'Last'),
      ])
    ])

# start it up!
React.renderComponent (PostsWrap { source: '/posts.json' }), document.getElementById('content')
