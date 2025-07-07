class CoffeeRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coffee_record, only: [:show, :edit, :update, :destroy]

  def index
    @coffee_records = CoffeeRecord.includes(:user).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
  end

  def new
    @coffee_record = current_user.coffee_records.build
  end

  def create
    @coffee_record = current_user.coffee_records.build(coffee_record_params)
    if @coffee_record.save
      redirect_to coffee_records_path, notice: 'コーヒー記録を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @coffee_record.update(coffee_record_params)
      redirect_to coffee_records_path, notice: 'コーヒー記録を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @coffee_record.destroy
    redirect_to coffee_records_path, notice: 'コーヒー記録を削除しました'
  end

  private

  def set_coffee_record
    @coffee_record = current_user.coffee_records.find(params[:id])
  end

  def coffee_record_params
    params.require(:coffee_record).permit(
      :origin,
      :bean_type,
      :process_method,
      :roast_level,
      :acidity_level,
      :body_level,
      :notes,
      :image,
      :image_cache
    )
  end
end