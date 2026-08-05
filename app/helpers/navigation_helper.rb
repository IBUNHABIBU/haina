module NavigationHelper
  def nav_link_to(name, path, options = {})
    options[:class] ||= ""
    options[:class] += " inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium"
    
    if current_page?(path)
      options[:class] += " border-amber-300 text-gray-100"
    else
      options[:class] += " border-transparent text-gray-100 hover:border-amber-200 hover:text-amber-200"
    end
    
    link_to name, path, options
  end
  
  def mobile_nav_link_to(name, path, options = {})
    options[:class] ||= ""
    options[:class] += " block pl-3 pr-4 py-2 border-l-4 text-base font-medium"
    
    if current_page?(path)
      options[:class] += " bg-green-700 border-amber-300 text-amber-300"
    else
      options[:class] += " border-transparent text-gray-100 hover:bg-orange-800 hover:border-amber-200 hover:text-amber-200"
    end
    
    link_to name, path, options
  end

  def nav_items
    [
      ["Home", root_path],
      ["About Us", pages_about_path],
      ["Destinations", destinations_path],
      ["Tours", travel_tours_path],
      ["Trekking", trekkings_path],
      # ["Wildlife Safari", safaris_path],
      ["Testimonials", testimonials_path],
      ["Contact Us", pages_contact_path]
    ]
  end

  def mobile_only_items
    [
      ["Tours", travel_tours_path]
    ]
  end

  def admin_nav_items
    return [] unless user_signed_in? && (current_user.admin? || current_user.super_admin?)
    [["Dashboard", dashboard_path]]
  end
end