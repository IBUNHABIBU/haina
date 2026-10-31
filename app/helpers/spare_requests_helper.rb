module SpareRequestsHelper
  def spare_request_name(request)
    if request.spare_type.present?
      SpareRequest::SPARE_TYPES[request.spare_type] ||
        request.spare_type.humanize
    else
      request.spare&.name.presence || "Unknown spare"
    end
  end

  def spare_request_part_number(request)
    request.requested_part_number.presence ||
      request.spare&.part_number.presence ||
      "Not specified"
  end
end