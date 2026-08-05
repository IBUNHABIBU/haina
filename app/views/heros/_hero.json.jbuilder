json.extract! hero, :id, :title, :subtitle, :description, :created_at, :updated_at
json.url hero_url(hero, format: :json)
