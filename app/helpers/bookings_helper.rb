
module BookingsHelper
  def status_color(status)
    case status
    when 'confirmed' then 'bg-green-100 text-green-800'
    when 'cancelled' then 'bg-red-100 text-red-800'
    when 'completed' then 'bg-blue-100 text-blue-800'
    else 'bg-yellow-100 text-yellow-800'
    end
  end
  
  def status_icon(status)
    case status
    when 'confirmed' then '✓'
    when 'cancelled' then '✗'
    when 'completed' then '✓'
    else '⏳'
    end
  end
end