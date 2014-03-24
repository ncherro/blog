define ['react'], (React) ->

  D = React.DOM

  React.createClass
    render: ->
      D.p { className: 'loading' }, @props.text || 'Loading...'
