json.extract! blog, :id, :title, :content, :created_at, :updated_at
json.url blog_url(blog, format: :json)
json.content blog.content.to_s
