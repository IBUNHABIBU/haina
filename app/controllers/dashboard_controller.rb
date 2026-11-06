class DashboardController < ApplicationController
  before_action :authenticate_user!

def index
  @period = params[:period].presence_in(%w[daily weekly monthly yearly]) || "monthly"
  @range = period_range(@period)

  if params[:month].present? && params[:month].to_i.positive?
    month = params[:month].to_i
    year  = params[:year].presence&.to_i || Date.current.year
    @selected_month = month
    @selected_year  = year
    month_start = Date.new(year, month, 1)
    month_end   = month_start.end_of_month
    @activities = Activity.where(date_in: month_start..month_end)
  else
    @activities = Activity.where(date_in: @range)
  end

  # KPI (scoped kwa @activities)
  @sales        = @activities.sum(:price).to_d
  @gross_profit = @activities.sum(:gross_profit).to_d
  @expenses     = Expense.where(spent_on: @range.begin.to_date..@range.end.to_date).sum(:amount).to_d
  @net_profit   = @gross_profit - @expenses
  @repair_count = @activities.count
  @return_count = RepairReturn.where(returned_at: @range).count
  @low_stock_count = Rails.cache.fetch("low_stock_count", expires_in: 5.minutes) { Spare.low_stock.count }

  # Monthly graphs — query MOJA
  current_year = params[:year].presence&.to_i || Date.current.year
  year_range = Date.new(current_year, 1, 1)..Date.new(current_year, 12, 31)

  monthly_data = Activity
    .where(date_in: year_range)
    .group("EXTRACT(MONTH FROM date_in)")
    .pluck(
      Arel.sql("EXTRACT(MONTH FROM date_in)::int"),
      Arel.sql("SUM(price)"),
      Arel.sql("SUM(gross_profit)"),
      Arel.sql("COUNT(*)")
    )
    .to_h { |m, s, p, c| [m, { sales: s || 0, profit: p || 0, count: c || 0 }] }

  @monthly_sales   = (1..12).map { |m| [Date::MONTHNAMES[m], monthly_data.dig(m, :sales)  || 0] }.to_h
  @monthly_profit  = (1..12).map { |m| [Date::MONTHNAMES[m], monthly_data.dig(m, :profit) || 0] }.to_h
  @monthly_repairs = (1..12).map { |m| [Date::MONTHNAMES[m], monthly_data.dig(m, :count)  || 0] }.to_h

  # Sales by day — tumia @activities moja kwa moja
  @sales_by_day = @activities
    .where.not(price: [nil, 0])
    .group("DATE(date_in)")
    .sum(:price)
    .transform_keys { |d| d.strftime("%d %b") }
    .reject { |_date, amount| amount.to_f.zero? }

  # Top brands/sizes/cofs — scoped
  @top_brands = @activities.joins(:tv_brand).group("tv_brands.name").count.sort_by { |_, v| -v }.first(5).to_h
  @top_sizes  = @activities.joins(:tv_size).group("tv_sizes.size").count.sort_by { |_, v| -v }.first(5)
                           .map { |size, count| ["#{size} in", count] }.to_h
  @top_cofs   = @activities.where.not(cof_number: [nil, ""]).group(:cof_number).count.sort_by { |_, v| -v }.first(5).to_h
  @top_customers = @activities.joins(:customer).group("customers.name").count.sort_by { |_, v| -v }.first(5).to_h

  # Customer trend — scoped (angalia design yako)
  @customer_trend = case @period
    when "daily"   then @activities.group_by_day(:date_in, last: 7).distinct.count(:customer_id)
    when "weekly"  then @activities.group_by_week(:date_in, last: 8).distinct.count(:customer_id)
    when "monthly" then @activities.group_by_month(:date_in, last: 12).distinct.count(:customer_id)
    when "yearly"  then @activities.group_by_year(:date_in, last: 5).distinct.count(:customer_id)
  end.transform_keys { |d| d.strftime("%d %b") }

  # Debtors — moja query + limit
  @debtors = Activity.owed.includes(:customer, :tv_brand, :tv_size)
                     .order(Arel.sql("starting_price - price DESC"))
                     .limit(50)
                     .to_a
  debt_stats = Activity.owed.pick(
    Arel.sql("COUNT(*)"),
    Arel.sql("COALESCE(SUM(starting_price - price), 0)")
  )
  @debtors_count = debt_stats[0]
  @total_debt    = debt_stats[1]

  # Repair trend — scoped
  @repair_trend = case @period
    when "daily"   then @activities.group_by_day(:date_in, last: 7).count
    when "weekly"  then @activities.group_by_week(:date_in, last: 8).count
    when "monthly" then @activities.group_by_month(:date_in, last: 12).count
    when "yearly"  then @activities.group_by_year(:date_in, last: 5).count
  end

  @status_breakdown = @activities.group(:status).count.transform_keys { |k| k&.humanize || "Unknown" }

  respond_to do |format|
    format.html
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace("dashboard_content", partial: "dashboard/content")
    end
  end
end

  private

  def period_range(period)
    case period
    when "daily" then Time.current.all_day
    when "weekly" then Time.current.all_week
    when "yearly" then Time.current.all_year
    else Time.current.all_month
    end
  end
end