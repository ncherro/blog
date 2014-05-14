json_add_meta({
  current_page: (@posts.current_page > @posts.total_pages ? @posts.total_pages : @posts.current_page),
  total_pages: @posts.total_pages,
  total_count: @posts.total_count,
})

json.posts do
  json.array! @posts, partial: 'posts/post', as: :post
end
