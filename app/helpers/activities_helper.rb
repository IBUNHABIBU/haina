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
      { pill: "bg-violet-50 text-violet-700 ring-violet-200",
dot:  "bg-violet-400"}
      
    when "spare_requested"
      { pill: "bg-rose-100 text-rose-900 ring-rose-300",
dot:  "bg-rose-700" }
    when "diagnosing"
      { pill: "bg-blue-50 text-blue-700 ring-blue-200", dot: "bg-blue-500" }
    when "waiting_for_parts"
      { pill: "bg-amber-50 text-amber-700 ring-amber-200", dot: "bg-amber-500" }
    when "in_repair"
      { pill: "bg-indigo-50 text-indigo-700 ring-indigo-200", dot: "bg-indigo-500" }
    when "completed"
      { pill: "bg-emerald-50 text-emerald-700 ring-emerald-200", dot: "bg-emerald-500" }
    when "delivered"
      { pill: "bg-teal-50 text-teal-700 ring-teal-200", dot: "bg-teal-500" }
    when "returned"
      { pill: "bg-cyan-50 text-cyan-700 ring-cyan-200", dot: "bg-cyan-500" }
    when "irreparable", "irepairable" # Kumbuka typo iliyokuwa kwenye code yako ya awali
      { pill: "bg-rose-50 text-rose-700 ring-rose-200", dot: "bg-rose-500" }
    when "cancelled"
      { pill: "bg-gray-100 text-gray-600 ring-gray-200", dot: "bg-gray-400" }
    else
      { pill: "bg-slate-100 text-slate-700 ring-slate-200", dot: "bg-slate-400" }
    end
  end

  def highlight_search(text, query)
    return text if query.blank? || text.blank?
    escaped = ERB::Util.html_escape(text.to_s)
    q = ERB::Util.html_escape(query.to_s)
    escaped.gsub(/(#{Regexp.escape(q)})/i, '<mark class="bg-amber-200 text-slate-900 rounded px-0.5">\1</mark>').html_safe
  end
end