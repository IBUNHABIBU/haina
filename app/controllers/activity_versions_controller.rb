class ActivityVersionsController < ApplicationController
   before_action :authenticate_user!

  def index
    @item_type = params[:item_type]
    @item_id = params[:item_id]

   @versions = PaperTrail::Version
      .where(item_type: @item_type, item_id: @item_id)
      .where(event: "update")
      .order(created_at: :desc)
  end

end
