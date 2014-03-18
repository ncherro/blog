#= require_self
#= require ui/comments
#= require ui/posts
#= require ui/common
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./routers

window.Blog =
  Models: {}
  Collections: {}
  Routers: {}
  Ui: {}
  BackboneMixins:
    # getBackboneCollections() should return a collection
    componentDidMount: () ->
      # re-render whenever there may be a change in the Backbone data -
      bindCallbacks = (collection) ->
        # `@` is the react component
        #
        # explicitly bind `null` to `forceUpdate`, as it demands a callback and
        # React validates that it's a function.
        #
        # `collection` events pass additional arguments that are not functions
        collection.on('add remove change', @forceUpdate.bind(@, null))
      @getBackboneCollections().forEach(bindCallbacks, @)

    componentWillUnmount: () ->
      # `@` is the react component
      #
      # unbind listeners when the component is destroyed
      cleanup = (collection) ->
        collection.off(null, null, @)
      @getBackboneCollections().forEach(cleanup, @)


$ ->
  new Blog.Routers.Main()
  Backbone.history.start({ pushState: true })
