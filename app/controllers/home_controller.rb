class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    if user_signed_in?
      @recent_records = current_user.coffee_records.order(created_at: :desc).limit(3)
    end
  end
end
