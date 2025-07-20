class HomeController < ApplicationController
  def index
    @recent_records = if user_signed_in?
                        current_user.coffee_records.order(created_at: :desc).limit(3)
                      else
                        CoffeeRecord.includes(:user).order(created_at: :desc).limit(3)
                      end
  end
end
