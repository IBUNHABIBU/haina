json.extract! travel_tour, :id, :name, :description, :price, :duration, :category, :featured, :highlights, :includes, :created_at, :updated_at
json.url travel_tour_url(travel_tour, format: :json)
