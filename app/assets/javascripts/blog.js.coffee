#= require_self
#= require ui/comments
#= require ui/posts
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./routers

# TODO: use requirejs to handle dependency issues

window.Blog =
  Models: {}
  Collections: {}
  Routers: {}
  Ui: {}
  BackboneMixins:
    # both mixins require getBackboneCollections() to be defined in the React
    # component
    componentDidMount: () ->
      # re-render whenever there may be a change in the Backbone data -
      bindCallbacks = (collection) ->
        # explicitly bind `null` to `forceUpdate`, as it demands a callback and
        # React validates that it's a function. `collection` events pass
        # additional arguments that are not functions
        collection.on('add remove change', @forceUpdate.bind(@, null))
      @getBackboneCollections.forEach(bindCallbacks, @)

    componentWillUnmount: () ->
      # clean up references when the component is destroyed
      cleanup = (collection) ->
        collection.off(null, null, this)
      @getBackboneCollections.forEach(cleanup, @)


# start it up on document ready
$ ->
  React.renderComponent(
    (Blog.Ui.PostsWrap { posts: new Blog.collections.posts }),
    document.getElementById('content')
  )
