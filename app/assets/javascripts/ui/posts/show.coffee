define ['react',
  'jquery',
  'showdown',
  'ui/common/loading',
  'ui/comments/wrap',
  'require'], (React,
  $,
  Showdown,
  Loading,
  CommentsWrap,
  require) ->

  D = React.DOM
  converter = new Showdown.converter

  # NOTE: circular references prevent us from passing in MainRouter above -
  # this works, but it seems hacky...
  # TODO: find a better way (or delete this comment)
  MainRouter = null
  require ['routers/main'], (Router) ->
    MainRouter = Router

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
        D.div attrs, [
          D.h3 {}, [
            D.a { href: @props.post.get('href'), onClick: (e) ->
              e.preventDefault()
              new MainRouter().navigate($(e.target).attr('href'), true)
            }, @props.post.get('title')
          ]
          D.p {}, @props.post.get('pub_date_local')
          D.div { dangerouslySetInnerHTML: {
            __html: converter.makeHtml(@props.post.get('copy'))
          }}
          D.h3 {}, 'Author'
          D.p {}, @props.post.get('author').get('email')
          CommentsWrap
            comments: @props.post.get('comments')
            comments_count: @props.post.get('comments_count')
          D.hr {}
        ]
