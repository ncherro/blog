$ ->

  D = React.DOM

  converter = new Showdown.converter

  Post = React.createClass
    render: ->
      (D.div { className: 'post' }, [
        (D.h3 {}, @props.title),
        (D.p {}, @props.pub_date),
        (D.span { dangerouslySetInnerHTML: { __html: converter.makeHtml(@props.copy) }})
      ])

  Posts = React.createClass
    render: ->
      renderPost = (post) ->
        Post {
          title: post.title,
          copy: post.copy,
          pub_date: post.pub_date_local,
        }

      (D.div { className: 'posts' }, @props.data.map(renderPost))

  Wrap = React.createClass
    # callbacks
    dataReceived: (data) ->
      @setState {
        loading: false,
        current_page: data.meta.current_page,
        total_pages: data.meta.total_pages,
        posts: data.posts
      }

    # event handlers
    prevPage: (e) ->
      e.preventDefault
      page = @state.current_page - 1
      return if page < 0
      $.getJSON(@props.source + '?page=' + page, @dataReceived)

    nextPage: (e) ->
      e.preventDefault
      page = @state.current_page + 1
      return if page > @state.total_pages
      $.getJSON(@props.source + '?page=' + page, @dataReceived)

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
          (D.a { onClick: @prevPage, href: '#' }, 'Prev'),
          (D.a { onClick: @nextPage, href: '#' }, 'Next'),
        ])
        (Posts { data: @state.posts }),
        (D.p { className: 'pagination' }, [
          (D.a { onClick: @prevPage, href: '#' }, 'Prev'),
          (D.a { onClick: @nextPage, href: '#' }, 'Next'),
        ])
      ])

  # start it up!
  React.renderComponent (Wrap { source: '/posts.json' }), document.getElementById('content')
