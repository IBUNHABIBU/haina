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

    def status_select_classes(status)
    case status.to_s.downcase
    when "requested", "pending"
      "bg-amber-50 border-amber-200 text-amber-700"
    when "shipped"
      "bg-blue-50 border-blue-200 text-blue-700"
    when "received", "completed"
      "bg-emerald-50 border-emerald-200 text-emerald-700"
    when "rejected", "cancelled"
      "bg-rose-50 border-rose-200 text-rose-700"
    else
      "bg-slate-100 border-slate-200 text-slate-700"
    end
  end
end