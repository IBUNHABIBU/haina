class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @period = params[:period].presence_in(%w[daily weekly monthly yearly]) || "monthly"
    @range = period_range(@period)
    @activities = Activity.where(date_in: @range)
    @sales = @activities.sales.sum(:price).to_d
    @gross_profit = @activities.sales.sum(:gross_profit).to_d
    @expenses = Expense.where(spent_on: @range.begin.to_date..@range.end.to_date).sum(:amount).to_d
    @net_profit = @gross_profit - @expenses
    @repair_count = @activities.count
    @return_count = RepairReturn.where(returned_at: @range).count
    @low_stock_count = Spare.low_stock.count
    @sales_by_day = @activities.sales.group_by_day(:date_in, range: @range).sum(:price)
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
