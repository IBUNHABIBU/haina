module ActivitiesHelper
  # Returns a hash with the full styling for a status pill.
  # Usage:
  #   <% s = status_badge_color(activity.status) %>
  #   <span class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 text-xs font-medium ring-1 ring-inset <%= s[:pill] %>">
  #     <span class="h-1.5 w-1.5 rounded-full <%= s[:dot] %>"></span>
  #     <%= activity.status&.humanize || "Not set" %>
  #   </span>
  def status_badge_color(status)
    case status.to_s.downcase
    when "received"
      { pill: "bg-amber-50 text-amber-700 ring-amber-200",     dot: "bg-amber-500" }
    when "completed"
      { pill: "bg-emerald-50 text-emerald-700 ring-emerald-200", dot: "bg-emerald-500" }
    when "returned"
      { pill: "bg-blue-50 text-blue-700 ring-blue-200",       dot: "bg-blue-500" }
    when "irepairable", "irreparable"
      { pill: "bg-rose-50 text-rose-700 ring-rose-200",       dot: "bg-rose-500" }
    else
      { pill: "bg-slate-100 text-slate-700 ring-slate-200",   dot: "bg-slate-400" }
    end
  end
end