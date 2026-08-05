json.extract! testimonial, :id, :author_name, :author_title, :content, :rating, :created_at, :updated_at
json.url testimonial_url(testimonial, format: :json)
