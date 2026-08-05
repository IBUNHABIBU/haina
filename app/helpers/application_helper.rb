module ApplicationHelper
  
  def flash_class(type)
    base_classes = "relative rounded-lg p-4 mb-4 shadow-lg transition-all duration-300 transform hover:scale-[1.02]"
    
    case type.to_sym
    when :notice, :success
      "#{base_classes} bg-green-50 border-l-4 border-green-500 text-green-800"
    when :alert, :error
      "#{base_classes} bg-red-50 border-l-4 border-red-500 text-red-800"
    when :warning
      "#{base_classes} bg-yellow-50 border-l-4 border-yellow-500 text-yellow-800"
    else
      "#{base_classes} bg-blue-50 border-l-4 border-blue-500 text-blue-800"
    end
  end

  def flash_icon(type)
    case type.to_sym
    when :notice, :success
      '<svg class="h-5 w-5 text-green-500" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
      </svg>'.html_safe
    when :alert, :error
      '<svg class="h-5 w-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
      </svg>'.html_safe
    when :warning
      '<svg class="h-5 w-5 text-yellow-500" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
      </svg>'.html_safe
    else
      '<svg class="h-5 w-5 text-blue-500" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
      </svg>'.html_safe
    end
  end

 def flash_close_button_class(type)
  case type.to_sym
  when :notice, :success
    "text-green-500 hover:text-green-700"
  when :alert, :error
    "text-red-500 hover:text-red-700"
  when :warning
    "text-yellow-500 hover:text-yellow-700"
  else
    "text-blue-500 hover:text-blue-700"
  end
end

def flash_close_button_hover_class(type)
  case type.to_sym
  when :notice, :success
    "bg-green-100"
  when :alert, :error
    "bg-red-100"
  when :warning
    "bg-yellow-100"
  else
    "bg-blue-100"
  end
end

  def inline_svg_tag(filename, options = {})
  file_path = Rails.root.join('app', 'assets', 'images', "#{filename}.svg")
    if File.exist?(file_path)
      file_content = File.read(file_path)
      css_class = options[:class] || ''
      file_content.gsub('<svg', "<svg class='#{css_class}'").html_safe
    else
      content_tag(:span, "Icon not found: #{filename}", class: options[:class])
    end
  end

  def nav_link_to(text, path, options = {})
    options[:class] ||= ""
    options[:class] += " inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium"
    
    current_path = request.path
    is_current = current_path == path || (path != root_path && current_path.start_with?(path))
    
    if is_current
      options[:class] += " border-amber-300 text-gray-100" # Golden yellow border, white text
    else
      options[:class] += " border-transparent text-gray-300 hover:border-amber-300 hover:text-gray-100"
    end
    
    link_to text, path, options
  end

  def mobile_nav_link_to(text, path, options = {})
    options[:class] ||= ""
    options[:class] += " block pl-3 pr-4 py-2 border-l-4 text-base font-medium"
    
    current_path = request.path
    is_current = current_path == path || (path != root_path && current_path.start_with?(path))
    
    if is_current
      options[:class] += " border-amber-300 bg-orange-800 text-white"
    else
      options[:class] += " border-transparent text-gray-100 hover:bg-orange-800 hover:border-amber-300 hover:text-white"
    end
    
    link_to text, path, options
  end

  def role_badge_color(role)
    case role
    when 'super_admin'
      'bg-purple-100 text-purple-800'
    when 'admin'
      'bg-blue-100 text-blue-800'
    when 'user'
      'bg-gray-100 text-gray-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end


  def super_admin
    user_signed_in? && current_user.super_admin?
  end

  def full_title(page_title = '')
   base_title = "Impeccable Africa Tour| Tanzania Safaris"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def bullet_list(input)
    return "" if input.blank?

    # Split by newlines, remove empty lines, wrap each line in <li>
    items = input.lines.map(&:strip).reject(&:empty?).map do |line|
      "<li class='mb-1'>#{line}</li>"
    end

    "<ul class='list-disc list-inside space-y-1'>#{items.join}</ul>".html_safe
  end

end