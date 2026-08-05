class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin_access

  def index
    # You can add any dashboard statistics here later
    @video = Video.first

    @total_visits = Visit.count
    @today_visits = Visit.where("visited_at >= ?", Time.zone.today.beginning_of_day).count
    @visits_by_day = Visit.group_by_day(:visited_at, last: 7).count
  end

end