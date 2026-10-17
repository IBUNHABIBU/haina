module SparesHelper
  def highlight_search(text, query)
    return text if query.blank? || text.blank?
    escaped = ERB::Util.html_escape(text.to_s)
    q = ERB::Util.html_escape(query.to_s)
    escaped.gsub(/(#{Regexp.escape(q)})/i, '<mark class="bg-amber-200 text-slate-900 rounded px-0.5">\1</mark>').html_safe
  end
end