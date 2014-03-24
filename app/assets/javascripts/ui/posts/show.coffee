define ['react',
  'jquery',
  'showdown',
  'ui/common/loading',
  'routers/main',
  'ui/comments/wrap'], (React,
  $,
  Showdown,
  Loading,
  MainRouter,
  CommentsWrap) ->

  console.log MainRouter

  D = React.DOM
  converter = new Showdown.converter

  React.createClass
    # event handlers
    handleChanged: (model, options) ->
      @setState
        loading: false

    # react
    getInitialState: ->
      loading: true

    componentWillUnmount: ->
      # unbind all event listeners in @ context
      @props.post.off null, null, @

    componentWillMount: ->
      @setState
        loading: @props.standalone

      # update our state when the model changes
      @props.post.on 'change', @handleChanged, @

      if @props.standalone
        @props.post.fetch data: { all_comments: true }

    render: ->
      if @state.loading
        Loading()
      else
        attrs = { className: 'post' }
        attrs['id'] = 'posts-wrap' if @props.standalone
        router = new MainRouter()
        D.div attrs, [
          D.h3 {}, [
            D.a { href: @props.post.get('url'), onClick: (e) ->
              e.preventDefault()
              router.navigate($(e.target).attr('href'), true)
            }, @props.post.get('title')
          ]
          D.p {}, @props.post.get('pub_date_local')
          D.div { dangerouslySetInnerHTML: {
            __html: converter.makeHtml(@props.post.get('copy'))
          }}
          CommentsWrap
            comments: @props.post.get('comments')
            comments_count: @props.post.get('comments_count')
          D.hr {}
        ]
