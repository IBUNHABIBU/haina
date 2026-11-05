class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @period = params[:period].presence_in(%w[daily weekly monthly yearly]) || "monthly"
    
    @range = period_range(@period)

    # Filter ya mwezi (mpya)
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

    # Queries zilizopo
    @sales = @activities.sum(:price).to_d
    @gross_profit = @activities.sum(:gross_profit).to_d
    @expenses = Expense.where(spent_on: @range.begin.to_date..@range.end.to_date).sum(:amount).to_d
    @net_profit = @gross_profit - @expenses
    @repair_count = @activities.count
    @return_count = RepairReturn.where(returned_at: @range).count
    @low_stock_count = Spare.low_stock.count

    @sales_by_day = Activity
      .where(date_in: @activities.select(:date_in))
      .where.not(price: [nil, 0])
      .group("DATE(date_in)")
      .sum(:price)
      .transform_keys { |d| d.strftime("%d %b") }
      .reject { |_date, amount| amount.to_f.zero? }

    @top_brands = @activities.joins(:tv_brand)
                             .group("tv_brands.name")
                             .count
                             .sort_by { |_, v| -v }
                             .first(5)
                             .to_h

    @top_sizes = @activities.joins(:tv_size)
                            .group("tv_sizes.size")
                            .count
                            .sort_by { |_, v| -v }
                            .first(5)
                            .map { |size, count| ["#{size} in", count] }
                            .to_h

    @top_cofs = @activities.where.not(cof_number: [nil, ""])
                           .group(:cof_number)
                           .count
                           .sort_by { |_, v| -v }
                           .first(5)
                           .to_h

    @top_customers = @activities
      .joins(:customer)
      .group("customers.name")
      .count
      .sort_by { |_, v| -v }
      .first(5)
      .to_h

    case @period
    when "daily"
      @customer_trend = @activities.group_by_day(:date_in, last: 7).distinct.count(:customer_id)
    when "weekly"
      @customer_trend = @activities.group_by_week(:date_in, last: 8).distinct.count(:customer_id)
    when "monthly"
      @customer_trend = @activities.group_by_month(:date_in, last: 12).distinct.count(:customer_id)
    when "yearly"
      @customer_trend = @activities.group_by_year(:date_in, last: 5).distinct.count(:customer_id)
    end

    @debtors = Activity.owed.includes(:customer, :tv_brand, :tv_size)
                      .order(Arel.sql("starting_price - price DESC"))
                      .to_a

    @debtors_count = Activity.owed.count
    @total_debt = Activity.owed.sum(Arel.sql("starting_price - price"))

    case @period
    when "daily"
      @repair_trend = @activities.group_by_day(:date_in, last: 7).count
    when "weekly"
      @repair_trend = @activities.group_by_week(:date_in, last: 8).count
    when "monthly"
      @repair_trend = @activities.group_by_month(:date_in, last: 12).count
    when "yearly"
      @repair_trend = @activities.group_by_year(:date_in, last: 5).count
    end

    @status_breakdown = @activities.group(:status).count.transform_keys { |k| k&.humanize || "Unknown" }

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "dashboard_content",
          partial: "dashboard/content"
        )
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