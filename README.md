 <div class="flex items-center gap-3">
    <div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-indigo-100 text-xs font-semibold text-indigo-700">
    <%= activity.customer&.name.to_s.first&.upcase || "?" %>
    </div>
    <div>
    <div class="text-sm font-medium text-slate-900"><%= highlight_search(activity.customer&.name, query) || "—" %></div>
    <% if activity.customer&.phone.present? %>
        <div class="text-xs text-slate-500"><%= highlight_search(activity.customer.phone, query) %></div>
    <% end %>
    </div>
</div>