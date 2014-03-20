json.meta do
  json.total_count @total_count
end
json.comments do
  json.array! @comments, partial: 'comments/comment', as: :comment
end
