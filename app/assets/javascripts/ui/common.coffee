(() ->
  D = React.DOM

  Blog.Ui.Loading = React.createClass
    render: ->
      D.p { className: 'loading' }, 'Loading...'

)()