json.id post.id
json.title post.title
json.href post_path(post)
json.copy (params[:action] == 'show' ? post.copy : truncate(post.copy, length: 100, separator: ' '))
json.pub_date_local l(post.pub_date)
json.created_at post.created_at.to_i

json.comments_count post.comments.count

json_add_linked(
  'posts.tags',
  post.tags,
  partial: 'tags/tag',
  &:id
)

comments = post.comments
comments = comments.limit(3) unless params[:action] == 'show' && params[:all_comments]
json_add_linked(
  'posts.comments',
  comments,
  partial: 'comments/comment',
  &:id
)

json_add_linked(
  'posts.author',
  post.user,
  href: user_path('{posts.author}'),
  partial: 'users/user',
  type: 'users',
  &:id
)

json_print_links(json)
