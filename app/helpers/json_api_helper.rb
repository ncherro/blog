require 'cgi'

# helper for our JSON API
module JsonApiHelper
  # caches meta keys / vals into @json_meta, to be printed into the top-level
  # `meta` json object
  #
  # ==== Attributes
  #
  # * +obj+ - keys / values to be merged in
  def json_add_meta(obj)
    @json_meta ||= {}
    @json_meta.merge! obj
    nil
  end

  # caches linked objects into @json_tl_linked, to be printed into the
  # top-level `linked` json object
  #
  # ==== Attributes
  #
  # * +key+ - the `linked` key to this list of objects
  # * +objects+ - objects to which we are linking (may be a single object)
  # * +opts+ - hash - allows user to override the key used in the individual
  # resource's `links` section. useful for belongs_to / has_one relationships
  # also allows user to set the json partial
  #
  # &block will be called on the object(s) to set the value for the `links` in
  # individual resources
  def json_add_linked(key, objects, opts = {}, &block)
    link_key = key.split('.').last
    opts = {
      partial: nil,
      type: link_key,
      href: nil
    }.merge(opts)
    @json_tl_linked ||= {}
    @json_tl_linked[opts[:type]] ||= {}
    @json_tl_linked[opts[:type]][:objects] ||= []
    @json_tl_linked[opts[:type]][:partial] = opts[:partial]

    # ensure linked objects are an array
    @json_tl_linked[opts[:type]][:objects] += [*objects]

    @json_tl_links ||= {}
    tl_links = { type: opts[:type] }
    tl_links[:href] = CGI.unescape(opts[:href]) if opts[:href]
    @json_tl_links[key] = tl_links
    if objects.respond_to?(:each)
      # store an array of keys
      json_add_links(link_key, opts[:type], objects.map(&block))
    else
      # store one key
      json_add_links(link_key, opts[:type], yield(objects))
    end
    nil
  end

  # caches links into @json_links, which are printed in individual resources
  #
  # ==== Attributes
  #
  # * +key+ - key to the link
  # * +val+ - link values (will be either single key to a linked object, or an
  # array of keys to linked objects)
  def json_add_links(key, type, val)
    @json_links ||= {}
    @json_links[key] = val
  end

  # prints json `meta` object into the top-level
  #
  # ==== Attributes
  #
  # * +json+ - references to the jbuilder json object
  # * +reset+ - boolean (defaults to true) resets the cache after rendering
  def json_print_meta(json, reset = true)
    json.meta do
      json.status response.status
      if @json_meta && @json_meta.any?
        @json_meta.each do |k, v|
          json.set! k, v
        end
      end
      @json_meta = {} if reset
    end
  end

  # prints json `linked` and `links` objects into the top-level, ensuring
  # uniqueness in `linked`
  #
  # ==== Attributes
  #
  # * +json+ - references to the jbuilder json object
  # * +reset+ - boolean (defaults to true) resets the cache after rendering
  def json_print_linked(json, reset = true)
    json_print_tl_linked(json, reset)
    json_print_tl_links(json, reset)
  end

  def json_print_tl_linked(json, reset = true)
    if @json_tl_linked && @json_tl_linked.any?
      json.linked do
        @json_tl_linked.each do |key, opts|
          if opts[:partial]
            json.set! key do
              json.array! opts[:objects].uniq do |obj|
                json.partial! opts[:partial], obj: obj
              end
            end
          else
            # just render the json
            json.set! key, opts[:objects].uniq
          end
        end
      end
      @json_tl_linked = {} if reset
    end
  end

  def json_print_tl_links(json, reset = true)
    if @json_tl_links && @json_tl_links.any?
      json.links do
        @json_tl_links.each do |key, opts|
          json.set! key, opts
        end
      end
    end
  end

  # prints json `links` object into the individual resource
  #
  # ==== Attributes
  #
  # * +json+ - references to the jbuilder json object
  # * +reset+ - boolean (defaults to true) resets the cache after rendering
  def json_print_links(json, reset = true)
    if @json_links && @json_links.any?
      json.links do
        @json_links.each do |k, v|
          json.set! k, v
        end
      end
      @json_links = {} if reset
    end
  end
end
