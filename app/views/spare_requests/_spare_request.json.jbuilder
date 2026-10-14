json.extract! spare_request, :id, :activity_id, :spare_id, :requested_by_id, :issued_by_id, :requested_quantity, :issued_quantity, :unit_cost_at_issue, :status, :reason, :store_notes, :issued_at, :created_at, :updated_at
json.url spare_request_url(spare_request, format: :json)
