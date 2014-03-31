define ['react', 'underscore'], (React, _) ->

  D = React.DOM

  React.createClass
    # event handlers
    handleChange: (e) ->
      @setState
        content: e.target.value

    handleSubmit: (e) ->
      e.preventDefault()
      @props.comments.create(content: @state.content, {
        wait: true
        success: (model, response, options) =>
          @setState
            content: ''
            errors: []
            message: 'Your comment has been saved!'

        error: (model, xhr, options) =>
          errors = xhr.responseJSON
          r = []
          _.map errors, (errors_a, key) ->
            _.map errors_a, (error) ->
              r.push("#{key} #{error}")
          @setState
            errors: r
            message: ''
      })

    # react
    getInitialState: ->
      content: ''
      errors: []
      message: ''

    render: ->
      D.form { onSubmit: @handleSubmit }, [
        D.h3 {}, 'New Comment'
        if @state.message
          D.h4 {}, @state.message
        if @state.errors.length
          [
            (D.h4 {}, "#{@state.errors.length} error(s) prevented your comment from being saved:"),
            D.ul {}, _.map @state.errors, (error_str) ->
              D.li {}, error_str
          ]
        D.input {
          type: 'text'
          onChange: @handleChange
          placeholder: 'Comment'
          value: @state.content
        }
        D.button { type: 'submit' }, 'Submit'
      ]
