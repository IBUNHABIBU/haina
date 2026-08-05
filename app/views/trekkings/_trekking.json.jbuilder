json.extract! trekking, :id, :title, :duration, :difficulty, :overview_title, :overview_description, :content, :created_at, :updated_at
json.url trekking_url(trekking, format: :json)
json.content trekking.content.to_s
