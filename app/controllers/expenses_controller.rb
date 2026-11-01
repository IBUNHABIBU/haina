class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
  @expenses = Expense.order(spent_on: :desc)

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
    date = Date.parse("#{params[:month]}-01")
    @expenses = @expenses.where(spent_on: date.all_month)
  end

  if params[:category].present?
    @expenses = @expenses.where(category: params[:category])
  end

  @total_filtered_amount = @expenses.sum(:amount)
  @this_month_total = Expense.where(spent_on: Date.today.all_month).sum(:amount)
  @record_count = @expenses.size
  @top_category = @expenses.reorder(nil).group(:category).sum(:amount).max_by { |_, v| v }
  @categories = Expense.distinct.pluck(:category).compact
  
  # HAKUNA respond_to HAPA
end

  def show; end

  def new
    @expense = Expense.new(spent_on: Date.current, category: "other")
  end

  def edit; end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: "Expense was successfully recorded.", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  # HAKIKISHA HII IPO
  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: "Expense was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  @expense.destroy!

  respond_to do |format|
    format.html do
      redirect_to expenses_path, alert: "Expense was deleted.", status: :see_other
    end

    format.turbo_stream do
      flash.now[:alert] = "Expense was deleted."
      render turbo_stream: [
        turbo_stream.prepend("flash", partial: "shared/flash_messages"),
        turbo_stream.update("expenses_list", partial: "expenses/list", locals: { expenses: Expense.order(spent_on: :desc) })
      ]
    end
  end
end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:category, :description, :amount, :spent_on, :reference, :notes)
  end
end