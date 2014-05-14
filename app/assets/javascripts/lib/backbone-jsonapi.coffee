define ['backbone'
  'underscore'], (Backbone
  _) ->

  utils =
    parse: (response) ->
      response

    getMainCollection: (response) ->
      response

  Backbone.JsonApiCollection = Backbone.Collection.extend
    parse: (response, options) ->
      return if response == undefined
      output = utils.parse(response)
      mainCollection = utils.getMainCollection(response)
      return _.each(
        output[mainCollection],
        (obj) ->
          obj._alreadyJSONAPIParsed = true
      )

  Backbone.JsonApiModel = Backbone.Model.extend
    parse: (response, options) ->
      return if response == undefined
      if response._alreadyJSONAPIParsed
        delete response._alreadyJSONAPIParsed
        return response
      output = utils.parse(response)
      mainCollection = utils.getMainCollection(response)
      output[mainCollection][0]

  Backbone
