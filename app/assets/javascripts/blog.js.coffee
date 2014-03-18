#= require_self
#= require ui/comments
#= require ui/posts
#= require_tree ./models
#= require_tree ./collections


window.Blog =
  Models: {}
  Collections: {}
  Ui: {}
  BackboneMixins:
    # getBackboneCollections() should return a collection
    componentDidMount: () ->

      console.log 'Blog.BackboneMixins.componentDidMount'

      # re-render whenever there may be a change in the Backbone data -
      bindCallbacks = (collection) ->
        # explicitly bind `null` to `forceUpdate`, as it demands a callback and
        # React validates that it's a function. `collection` events pass
        # additional arguments that are not functions
        collection.on('add remove change', @forceUpdate.bind(@, null))
      @getBackboneCollections().forEach(bindCallbacks, @)

    componentWillUnmount: () ->
      console.log 'component will unmount', @
      # clean up references when the component is destroyed
      cleanup = (collection) ->
        console.log 'cleanup', @, collection
        collection.off(null, null, this)
      @getBackboneCollections.forEach(cleanup, @)


$ ->
  React.renderComponent(
    (Blog.Ui.PostsWrap { posts: new Blog.Collections.Posts() }),
    document.getElementById('content')
  )
