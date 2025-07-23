class CoffeeRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coffee_record, only: %i[show edit update destroy]
  before_action :check_delete_permission, only: [:destroy]

  def index
    @coffee_records = CoffeeRecord.includes(:user).order(created_at: :desc).page(params[:page]).per(12)

    # 部分一致検索
    @coffee_records = @coffee_records.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    @coffee_records = @coffee_records.where('origin LIKE ?', "%#{params[:origin]}%") if params[:origin].present?
    @coffee_records = @coffee_records.where(roast_level: params[:roast_level]) if params[:roast_level].present?
    @coffee_records = @coffee_records.page(params[:page]).per(10)
  end

  def show; end

  def new
    @coffee_record = current_user.coffee_records.build
    @origins = %w[エチオピア ケニア コロンビア ブラジル グアテマラ コスタリカ パナマ ジャマイカ インドネシア ベトナム インド ペルー
                  ボリビア エルサルバドル ホンジュラス ニカラグア メキシコ ハワイ タンザニア ルワンダ]
    @bean_types = %w[アラビカ ロブスタ リベリカ ブルボン ティピカ カトゥーラ カツアイ ムンドノーボ パカマラ ゲイシャ エチオピアンヒエラルム
                     ケニアSL28 ケニアSL34]
    @process_methods = %w[ウォッシュド ナチュラル ハニー アナエロビック カーボニックマセレーション パルプドナチュラル]
    @roast_levels = %w[ライトロースト シナモンロースト ミディアムロースト ハイロースト シティロースト フルシティロースト フレンチロースト イタリアンロースト]
    @acidity_levels = %w[低 中低 中 中高 高]
    @body_levels = %w[軽い 中軽 中 中重 重い]
  end

  def edit
    @origins = %w[エチオピア ケニア コロンビア ブラジル グアテマラ コスタリカ パナマ ジャマイカ インドネシア ベトナム インド ペルー
                  ボリビア エルサルバドル ホンジュラス ニカラグア メキシコ ハワイ タンザニア ルワンダ]
    @bean_types = %w[アラビカ ロブスタ リベリカ ブルボン ティピカ カトゥーラ カツアイ ムンドノーボ パカマラ ゲイシャ エチオピアンヒエラルム
                     ケニアSL28 ケニアSL34]
    @process_methods = %w[ウォッシュド ナチュラル ハニー アナエロビック カーボニックマセレーション パルプドナチュラル]
    @roast_levels = %w[ライトロースト シナモンロースト ミディアムロースト ハイロースト シティロースト フルシティロースト フレンチロースト イタリアンロースト]
    @acidity_levels = %w[低 中低 中 中高 高]
    @body_levels = %w[軽い 中軽 中 中重 重い]
  end

  def create
    @coffee_record = current_user.coffee_records.build(coffee_record_params)
    if @coffee_record.save
      redirect_to coffee_records_path, notice: 'コーヒー記録を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
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
    @coffee_record = CoffeeRecord.find(params[:id])
  end

  def check_delete_permission
    return if @coffee_record.can_delete?(current_user)

    redirect_to coffee_records_path, alert: '削除権限がありません'
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
