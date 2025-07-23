module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin

    def index
      @total_users = User.count
      @total_coffee_records = CoffeeRecord.count
      @today_records = CoffeeRecord.where(created_at: Date.current.all_day).count
      @top_user = User.joins(:coffee_records).group('users.id').order(Arel.sql('COUNT(coffee_records.id) DESC')).first
      @popular_origins = CoffeeRecord.group(:origin).order(Arel.sql('COUNT(*) DESC')).limit(5).count
      @popular_roast_levels = CoffeeRecord.group(:roast_level).order(Arel.sql('COUNT(*) DESC')).limit(5).count
    end

    private

    def check_admin
      return if current_user.admin?

      redirect_to root_path, alert: '管理者権限が必要です'
    end
  end
end
