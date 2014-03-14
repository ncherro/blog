json.meta do
  json.current_page @posts.current_page
  json.total_pages @posts.total_pages
end
json.posts do
  json.array! @posts do |post|
    json.title post.title
    json.url url_for(post)
    json.copy post.copy
    json.pub_date post.pub_date
    json.pub_date_local l(post.pub_date)
    json.tags do
      json.array! post.tags do |tag|
        json.name tag.name
        json.url url_for(tag)
      end
    end
  end
end
