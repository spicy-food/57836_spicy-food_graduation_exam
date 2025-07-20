class HomeController < ApplicationController
  def index
    if user_signed_in?
      @recent_records = current_user.coffee_records.order(created_at: :desc).limit(3)
    else
      @recent_records = CoffeeRecord.includes(:user).order(created_at: :desc).limit(3)
    end
  end
end