module NavigationHelper
  def nav_link_to(name, path, options = {})
    options[:class] ||= ""
    options[:class] += " inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium"
    options[:class] += current_page?(path) ? " border-amber-300 text-gray-100" : " border-transparent text-gray-100 hover:border-amber-200 hover:text-amber-200"
    link_to name, path, options
  end

  def mobile_nav_link_to(name, path, options = {})
    options[:class] ||= ""
    options[:class] += " block pl-3 pr-4 py-2 border-l-4 text-base font-medium"
    options[:class] += current_page?(path) ? " bg-green-700 border-amber-300 text-amber-300" : " border-transparent text-gray-100 hover:bg-orange-800 hover:border-amber-200 hover:text-amber-200"
    link_to name, path, options
  end

  def nav_items
    items = [["Home", root_path], ["Dashboard", dashboard_path], ["Activities", activities_path], ["Spares", spares_path], ["Expenses", expenses_path]]
    user_signed_in? ? items : [["Home", root_path]]
  end

  def mobile_only_items
    []
  end

  def admin_nav_items
    return [] unless user_signed_in? && (current_user.admin? || current_user.super_admin?)
    [["Users", users_path], ["Spare Categories", spare_categories_path]]
  end
end
