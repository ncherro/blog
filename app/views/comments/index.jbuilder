json.meta do
json.current_page (@comments.current_page > @comments.total_pages ? @comments.total_pages : @comments.current_page)
json.total_pages @comments.total_pages
json.total_count @comments.total_count
end
json.comments do
  json.array! @comments, partial: 'comments/comment', as: :comment
end
