class RepairReturnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity
  before_action :set_repair_return, only: %i[show edit update destroy]

  def new
    @repair_return = @activity.repair_returns.build(returned_at: Time.current, status: "received")
  end

  def create
    @repair_return = @activity.repair_returns.build(repair_return_params)
    if @repair_return.save
      @activity.update!(status: :returned)
      redirect_to @activity, notice: "Return ##{@repair_return.return_number} was recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @repair_return.update(repair_return_params)
      redirect_to @activity, notice: "Return record was updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repair_return.destroy!
    redirect_to @activity, notice: "Return record was deleted.", status: :see_other
  end

  private

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_repair_return
    @repair_return = @activity.repair_returns.find(params[:id])
  end

  def repair_return_params
    params.require(:repair_return).permit(:returned_at, :location, :reason, :condition, :status, :notes)
  end
end
