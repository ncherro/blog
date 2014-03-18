json.meta do
  json.current_page @posts.current_page
  json.total_pages @posts.total_pages
  json.total_count @posts.total_count
end
json.posts do
  json.array! @posts, partial: 'posts/post', as: :post
end
