define ['backbone'
  'underscore'], (Backbone
  _) ->

  utils =
    parse: (response) ->
      console.log 'parsing'

  Backbone.JsonApiModel = Backbone.Model.extend
    parse: (response, options) ->
      utils.parse(response)

  Backbone.JsonApiCollection = Backbone.Collection.extend
    parse: (response, options) ->
      utils.parse(response)

  Backbone
