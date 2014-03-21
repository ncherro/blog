all_comments ||= false

json.id post.id
json.title post.title
json.url post_path(post)
json.copy (params[:action] == 'show' ? post.copy : truncate(post.copy, length: 100, separator: ' '))
json.pub_date post.pub_date
json.pub_date_local l(post.pub_date)

json.tags do
  json.array! post.tags do |tag|
    json.name tag.name
    json.url tag_path(tag)
  end
end

json.comments_count post.comments.count
json.comments do
  comments = post.comments.ordered
  comments = comments.limit(3) unless all_comments
  json.array! comments,
    partial: 'comments/comment',
    as: :comment
end
