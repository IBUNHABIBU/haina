# app/helpers/expenses_helper.rb
module ExpensesHelper
  def filter_pill_classes(is_active)
    base_classes = "rounded-full px-3.5 py-1.5 text-sm font-medium transition border"
    
    if is_active
      # Rangi ya bluu (Indigo) ikiwa imechaguliwa
      "#{base_classes} bg-indigo-600 border-indigo-600 text-white shadow-sm"
    else
      # Rangi nyeupe ikiwa haijachaguliwa
      "#{base_classes} bg-white border-slate-200 text-slate-600 hover:bg-slate-50 hover:text-slate-900"
    end
  end
end