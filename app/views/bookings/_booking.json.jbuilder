json.extract! booking, :id, :full_name, :email, :phone, :trek_name, :start_date, :end_date, :number_of_people, :special_requests, :status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
