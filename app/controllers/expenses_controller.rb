class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = Expense.order(spent_on: :desc)

    # 1. Filter by Quick Date Filters (Q1, Q2, Q3, Q4, This Year) au Month
    if params[:filter].present?
      case params[:filter]
      when "q1"
        @expenses = @expenses.where(spent_on: Date.today.beginning_of_year..Date.today.beginning_of_year.end_of_quarter)
      when "q2"
        start_date = Date.today.beginning_of_year + 3.months
        @expenses = @expenses.where(spent_on: start_date..start_date.end_of_quarter)
      when "q3"
        start_date = Date.today.beginning_of_year + 6.months
        @expenses = @expenses.where(spent_on: start_date..start_date.end_of_quarter)
      when "q4"
        start_date = Date.today.beginning_of_year + 9.months
        @expenses = @expenses.where(spent_on: start_date..start_date.end_of_quarter)
      when "this_year"
        @expenses = @expenses.where(spent_on: Date.today.all_year)
      end
    elsif params[:month].present?
      # Kama wametumia kichujio cha mwezi (Month Picker)
      date = Date.parse("#{params[:month]}-01")
      @expenses = @expenses.where(spent_on: date.all_month)
    end

    # 2. Filter by Category
    if params[:category].present?
      @expenses = @expenses.where(category: params[:category])
    end

    # KPI zinatakiwa zionyeshe data ya kile kilichochujwa
    @total_filtered_amount = @expenses.sum(:amount)
    
    # Tumia database query badala ya Ruby select ili iwe fast
    @this_month_total = @expenses.where(spent_on: Date.today.all_month).sum(:amount)
    
    @record_count = @expenses.size
    @top_category = @expenses.reorder(nil).group(:category).sum(:amount).max_by { |_, v| v }
    @categories = Expense.distinct.pluck(:category).compact

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "expenses_list",
          partial: "expenses/list",
          locals: { expenses: @expenses }
        )
      end
    end
  end

  def show; end

  def new
    @expense = Expense.new(spent_on: Date.current, category: "other")
  end

  def edit; end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: "Expense was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: "Expense was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy!
    redirect_to expenses_path, notice: "Expense was deleted.", status: :see_other
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:category, :description, :amount, :spent_on, :reference, :notes)
  end
end