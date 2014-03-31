define ['react',
        'models/post'], (React,
        PostModel) ->

  D = React.DOM

  React.createClass

    handleSubmit: (e) ->
      e.preventDefault()
      return false if @state.loading

      @setState { loading: true }

      @props.posts.create({
        title: @refs.title.getDOMNode().value.trim()
        copy: @refs.copy.getDOMNode().value.trim()
      }, {
        wait: true
        success: (model, response, options) =>
          @setState { loading: false }
        error: (model, xhr, options) =>
          @setState { loading: false }
      })

    getInitialState: ->
      errors: []
      loading: false
      title: ''
      copy: ''

    render: ->
      D.div { id: 'posts-form' }, [
        D.h3 {}, 'New post'
        if @state.loading
          D.p {}, 'Loading...'
        else
          if @state.errors.length
            D.p {}, "#{@state.errors.length} errors prevented this from being saved"
          D.form { onSubmit: @handleSubmit }, [
            D.input { type: 'text', name: 'title', ref: 'title' }
            D.textarea { name: 'copy', ref: 'copy' }
            D.button { type: 'submit' }, 'Save'
          ]
      ]

