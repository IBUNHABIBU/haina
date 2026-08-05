module TrekkingsHelper
  def difficulty_color(difficulty)
    case difficulty
    when 'easy' then 'green'
    when 'medium' then 'yellow'
    when 'challenging' then 'red'
    else 'gray'
    end
  end
end