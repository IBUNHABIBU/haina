
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # ============================================================
    # 1. FILTERS
    # ============================================================

    @period = params[:period].presence_in(%w[daily weekly monthly yearly]) || "monthly"

    current_year = params[:year].presence&.to_i || Date.current.year

    # Zuia year isiyo sahihi
    current_year = Date.current.year unless current_year.between?(1900, 2100)

    selected_month = params[:month].to_i
    selected_month = nil unless selected_month.between?(1, 12)

    @selected_month = selected_month
    @selected_year = current_year

    # Selected month inakuwa na priority kuliko period
    if @selected_month
      month_start = Date.new(current_year, selected_month, 1)

      @range = month_start.beginning_of_day..month_start.end_of_month.end_of_day
      @chart_period_label = "#{month_start.strftime('%B %Y')}"
      @chart_bucket = :day
    else
      @range = period_range(@period)

      @chart_period_label = @period.humanize

      @chart_bucket =
        case @period
        when "daily"   then :hour
        when "weekly"  then :day
        when "monthly" then :day
        when "yearly"  then :month
        end
    end

    # Labels za graph
    @chart_label_format =
      case @chart_bucket
      when :hour  then "%H:%M"
      when :month then "%b %Y"
      else "%d %b"
      end

    # Activities zote za kipindi kilichochaguliwa
    @activities = Activity.where(date_in: @range)

    # ============================================================
    # 2. KPI CARDS
    # ============================================================

    @sales = @activities.sum(:price).to_d

    @gross_profit = @activities.sum(:gross_profit).to_d

    @expenses = Expense
      .where(spent_on: @range.begin.to_date..@range.end.to_date)
      .sum(:amount)
      .to_d

    @net_profit = @gross_profit - @expenses

    @repair_count = @activities.count

    @return_count = RepairReturn.where(returned_at: @range).count

    @low_stock_count = Rails.cache.fetch(
      "low_stock_count",
      expires_in: 5.minutes
    ) do
      Spare.low_stock.count
    end

    # ============================================================
    # 3. MTTR
    # ============================================================

    completed = @activities
      .where(status: %w[completed delivered])
      .where.not(date_in: nil)

    mttr_sql = Arel.sql(
      "EXTRACT(EPOCH FROM (COALESCE(completed_at, updated_at) - date_in)) / 3600.0"
    )

    @mttr_avg_hours =
      if completed.exists?
        completed.average(mttr_sql).to_f.round(1)
      else
        0
      end

    # ============================================================
    # 4. COMMON GRAPH GROUPING
    # ============================================================

    # Daily   = hours
    # Weekly  = days
    # Monthly = days
    # Yearly  = months
    # Selected month = days

    grouped_activities = @activities.public_send(
      "group_by_#{@chart_bucket}",
      :date_in,
      range: @range
    )

    # ============================================================
    # 5. SALES TREND
    # ============================================================

    @sales_trend = @activities
      .where.not(price: nil)
      .public_send(
        "group_by_#{@chart_bucket}",
        :date_in,
        range: @range
      )
      .sum(:price)
      .transform_keys { |date| date.strftime(@chart_label_format) }

    # ============================================================
    # 6. GROSS PROFIT TREND
    # ============================================================

    @profit_trend = grouped_activities
      .sum(:gross_profit)
      .transform_keys { |date| date.strftime(@chart_label_format) }

    # ============================================================
    # 7. REPAIRS TREND
    # ============================================================

    @repair_trend = grouped_activities
      .count
      .transform_keys { |date| date.strftime(@chart_label_format) }

    # ============================================================
    # 8. CUSTOMER TREND
    # ============================================================

    @customer_trend = grouped_activities
      .distinct
      .count(:customer_id)
      .transform_keys { |date| date.strftime(@chart_label_format) }

    # ============================================================
    # 9. MTTR TREND
    # ============================================================

    @mttr_trend = completed
      .public_send(
        "group_by_#{@chart_bucket}",
        :date_in,
        range: @range
      )
      .average(mttr_sql)
      .transform_keys { |date| date.strftime(@chart_label_format) }
      .transform_values { |hours| (hours || 0).round(1) }

    # ============================================================
    # 10. IRREPARABLE REASONS
    # ============================================================

    irreparable = @activities
      .where(status: :irreparable)
      .where.not(irreparable_reason: [nil, ""])

    # Irreparable by selected period and reason
    @irreparable_by_period_chart = irreparable
      .distinct
      .pluck(:irreparable_reason)
      .map do |reason|

        data = irreparable
          .where(irreparable_reason: reason)
          .public_send(
            "group_by_#{@chart_bucket}",
            :date_in,
            range: @range
          )
          .count
          .transform_keys { |date| date.strftime(@chart_label_format) }

        {
          name: reason,
          data: data
        }
      end

    # Irreparable by reason
    @irreparable_by_reason = irreparable
      .group(:irreparable_reason)
      .count
      .sort_by { |_, count| -count }
      .to_h

    @top_irreparable_reason = @irreparable_by_reason.first

    # ============================================================
    # 11. TOP TV BRANDS
    # ============================================================

    @top_brands = @activities
      .joins(:tv_brand)
      .group("tv_brands.name")
      .count
      .sort_by { |_, count| -count }
      .first(5)
      .to_h

    # ============================================================
    # 12. TOP TV SIZES
    # ============================================================

    @top_sizes = @activities
      .joins(:tv_size)
      .group("tv_sizes.size")
      .count
      .sort_by { |_, count| -count }
      .first(5)
      .map { |size, count| ["#{size} in", count] }
      .to_h

    # ============================================================
    # 13. TOP COF NUMBERS
    # ============================================================

    @top_cofs = @activities
      .where.not(cof_number: [nil, ""])
      .group(:cof_number)
      .count
      .sort_by { |_, count| -count }
      .first(5)
      .to_h

    # ============================================================
    # 14. TOP CUSTOMERS
    # ============================================================

    @top_customers = @activities
      .joins(:customer)
      .group("customers.name")
      .count
      .sort_by { |_, count| -count }
      .first(5)
      .to_h

    # ============================================================
    # 15. STATUS BREAKDOWN
    # ============================================================

    @status_breakdown = @activities
      .group(:status)
      .count
      .transform_keys { |status| status&.humanize || "Unknown" }

    # ============================================================
    # 16. SALES BY DAY
    # ============================================================

    @sales_by_day = @activities
      .where.not(price: [nil, 0])
      .group_by_day(:date_in, range: @range)
      .sum(:price)
      .transform_keys { |date| date.strftime("%d %b") }
      .reject { |_date, amount| amount.to_f.zero? }

    # ============================================================
    # 17. TOP 10 LONGEST REPAIR DURATIONS
    # ============================================================

    top_durations = @activities
      .where.not(date_in: nil)
      .includes(:customer, :tv_brand, :tv_size)
      .order(
        Arel.sql("(COALESCE(completed_at, NOW()) - date_in) DESC")
      )
      .limit(10)

    @top_durations = top_durations.map do |activity|
      end_time = activity.completed_at || Time.current

      duration =
        if activity.mttr_seconds.present?
          (activity.mttr_seconds / 3600.0).round(1)
        else
          ((end_time - activity.date_in) / 3600.0).round(1)
        end

      name = [
        activity.customer&.name || "Unknown",
        activity.tv_brand&.name || "TV",
        activity.tv_size&.size
      ].compact.join(" - ")

      [name, duration]
    end.to_h

    # ============================================================
    # 18. DEBTORS
    # ============================================================

    # Madeni yanaonyesha jumla ya madeni yote, si filter ya kipindi.

    @debtors = Activity.owed
      .includes(:customer, :tv_brand, :tv_size, :tatizo)
      .order(Arel.sql("starting_price - price DESC"))
      .limit(50)
      .to_a

    debt_stats = Activity.owed.pick(
      Arel.sql("COUNT(*)"),
      Arel.sql("COALESCE(SUM(starting_price - price), 0)")
    )

    @debtors_count = debt_stats[0] || 0
    @total_debt = debt_stats[1] || 0

    # ============================================================
    # 19. RESPONSE
    # ============================================================

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

  # ============================================================
  # PERIOD RANGE
  # ============================================================

  def period_range(period)
    case period
    when "daily"
      Time.current.all_day

    when "weekly"
      Time.current.all_week

    when "yearly"
      Time.current.all_year

    else
      Time.current.all_month
    end
  end
end
