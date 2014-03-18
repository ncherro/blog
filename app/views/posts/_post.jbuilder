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
json.comments do
  json.array! post.comments.ordered.limit(3),
    partial: 'comments/comment',
    as: :comment
end
json.has_more_comments (post.comments.count > 3)
json.comments_url post_comments_path(post)
