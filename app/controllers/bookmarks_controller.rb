class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coffee_record, only: [:create, :destroy]

  def create
    @bookmark = current_user.bookmarks.build(coffee_record: @coffee_record)
    if @bookmark.save
      redirect_back(fallback_location: coffee_records_path, notice: 'ブックマークに追加しました')
    else
      redirect_back(fallback_location: coffee_records_path, alert: 'ブックマークの追加に失敗しました')
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(coffee_record: @coffee_record)
    if @bookmark&.destroy
      redirect_back(fallback_location: coffee_records_path, notice: 'ブックマークを削除しました')
    else
      redirect_back(fallback_location: coffee_records_path, alert: 'ブックマークの削除に失敗しました')
    end
  end

  def index
    @bookmarked_records = current_user.bookmarked_coffee_records.includes(:user).order(created_at: :desc).page(params[:page]).per(12)
  end

  private

  def set_coffee_record
    @coffee_record = CoffeeRecord.find(params[:coffee_record_id])
  end
end