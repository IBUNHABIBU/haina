class SparePurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spare

  def index
    @purchases = @spare.spare_purchases.order(purchased_on: :desc, created_at: :desc)
  end

  def new
    @purchase = @spare.spare_purchases.build(purchased_on: Date.current, quantity: 1, unit_cost: @spare.unit_cost)
  end

  def create
    SparePurchase.transaction do
      @purchase = @spare.spare_purchases.build(purchase_params)
      @purchase.user = current_user
      @purchase.save!
      Expense.create!(
        user: current_user,
        category: "spares",
        description: "Spare purchase: #{@spare.name}",
        amount: @purchase.total_cost,
        spent_on: @purchase.purchased_on,
        reference: @purchase.reference,
        notes: @purchase.notes
      )
    end
    redirect_to spare_spare_purchases_path(@spare), notice: "Stock purchase recorded and added to expenses."
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  private

  def set_spare
    @spare = Spare.find(params[:spare_id])
  end

  def purchase_params
    params.require(:spare_purchase).permit(:quantity, :unit_cost, :supplier, :purchased_on, :reference, :notes)
  end
end
