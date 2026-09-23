class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = Expense.order(spent_on: :desc, created_at: :desc)
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
