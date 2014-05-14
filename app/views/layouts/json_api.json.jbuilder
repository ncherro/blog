json_print_meta json
json_print_linked json
json.set! (
  # root key defaults to the controller name - set @json_root_key in a view to
  # override
  @json_root_key || params[:controller].split('/').last
), JSON.parse(yield)
