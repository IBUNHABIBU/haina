# app/helpers/icons_helper.rb
module IconsHelper
  # def value_icon(icon_name, options = {})
  #   classes = "h-12 w-12 #{options[:class]}"
    
  #   case icon_name.to_sym
  #   when :sustainability
  #     <<~SVG.html_safe
  #       <svg class="#{classes}" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  #         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
  #       </svg>
  #     SVG
  #   when :authenticity
  #     <<~SVG.html_safe
  #       <svg class="#{classes}" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  #         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
  #       </svg>
  #     SVG
  #   when :adventure
  #     <<~SVG.html_safe
  #       <svg class="#{classes}" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  #         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
  #       </svg>
  #     SVG
  #   when :community
  #     <<~SVG.html_safe
  #       <svg class="#{classes}" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  #         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
  #       </svg>
  #     SVG
  #   when :safety
  #     <<~SVG.html_safe
  #       <svg class="#{classes}" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  #         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
  #       </svg>
  #     SVG
  #   else
  #     <<~SVG.html_safe
  #       <svg class="#{classes}" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  #         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13 10V3L4 14h7v7l9-11h-7z" />
  #       </svg>
  #     SVG
  #   end
  # end

   def value_icon(icon_name, classes = "")
      icon_map = {
        sustainability: heroicon("globe-alt", variant: :solid, options: { class: classes }),
        authenticity:   heroicon("check-badge", variant: :solid, options: { class: classes }),
        shield_check:   heroicon("shield-check", variant: :solid, options: { class: classes }),
        users:          heroicon("users", variant: :solid, options: { class: classes }),
        sparkles:       heroicon("sparkles", variant: :solid, options: { class: classes }),
        rocket_launch:  heroicon("rocket-launch", variant: :solid, options: { class: classes }),

        inclusivity:    heroicon("user-group", variant: :solid, options: { class: classes }),
        integrity:      heroicon("scale", variant: :solid, options: { class: classes }),
        passion:        heroicon("heart", variant: :solid, options: { class: classes }),
      }

      icon_map[icon_name] || content_tag(:div, icon_name.to_s.first(2).upcase, class: classes)
   end

end