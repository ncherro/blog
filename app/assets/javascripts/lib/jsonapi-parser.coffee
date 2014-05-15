define ['underscore'], (_) ->

  class JsonApiParser

    constructor: (@response, @mainCollection) ->

    setHref: (item, collection, href) ->
      pattern = new RegExp("{#{collection}\\..*}")
      if pattern.test(href)
        item.href = href.split(pattern).join(item.id)

    processLinks: (key, obj) ->
      sp = key.split('.')
      collection = sp[0]
      relatedKey = sp[1]

      # loop through the collection and add the related item / items
      linkedKey = obj.type || relatedKey
      for item in @response[collection]
        if _.isArray(item.links[relatedKey])
          # set to an array of linked items
          item[relatedKey] = _.filter @response.linked[linkedKey], (linkedItem) ->
            _.indexOf(item.links[relatedKey], linkedItem.id) > -1
          if obj.href
            @setHref relatedItem, collection, obj.href for relatedItem in item[relatedKey]
        else
          item[relatedKey] = _.findWhere(
            @response.linked[linkedKey],
            id: item.links[relatedKey]
          )
          if obj.href
            @setHref item[relatedKey], collection, obj.href
        item._alreadyJSONAPIParsed = true
        # NOTE: why does this break things?
        # delete item.links

    parse: ->
      for key, obj of @response.links
        @processLinks(key, obj)
      @response

    parsedForCollection: ->
      return if @response == undefined
      @parse()[@mainCollection]

    parsedForModel: ->
      return if @response == undefined
      if @response._alreadyJSONAPIParsed
        delete @response._alreadyJSONAPIParsed
        return @response
      @parse()[@mainCollection][0]
