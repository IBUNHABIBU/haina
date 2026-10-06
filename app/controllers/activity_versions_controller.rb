class ActivityVersionsController < ApplicationController
   before_action :authenticate_user!
  before_action :set_activity

  def index
    @versions = @activity.versions.includes(:item).order(created_at: :desc)
  end

  private

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end
end
