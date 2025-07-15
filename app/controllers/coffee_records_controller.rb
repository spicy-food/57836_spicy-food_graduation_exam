class CoffeeRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coffee_record, only: [:show, :edit, :update, :destroy]

  def index
    @coffee_records = CoffeeRecord.includes(:user).order(created_at: :desc).page(params[:page]).per(12)

    # 部分一致検索
  @coffee_records = @coffee_records.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
  @coffee_records = @coffee_records.where("origin LIKE ?", "%#{params[:origin]}%") if params[:origin].present?
  @coffee_records = @coffee_records.where(roast_level: params[:roast_level]) if params[:roast_level].present?

  # ページネーション（kaminariの場合）
  @coffee_records = @coffee_records.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @coffee_record = current_user.coffee_records.build
    @origins = ['エチオピア', 'ケニア', 'コロンビア', 'ブラジル', 'グアテマラ', 'コスタリカ', 'パナマ', 'ジャマイカ', 'インドネシア', 'ベトナム', 'インド', 'ペルー', 'ボリビア', 'エルサルバドル', 'ホンジュラス', 'ニカラグア', 'メキシコ', 'ハワイ', 'タンザニア', 'ルワンダ']
    @bean_types = ['アラビカ', 'ロブスタ', 'リベリカ', 'ブルボン', 'ティピカ', 'カトゥーラ', 'カツアイ', 'ムンドノーボ', 'パカマラ', 'ゲイシャ', 'エチオピアンヒエラルム', 'ケニアSL28', 'ケニアSL34']
    @process_methods = ['ウォッシュド', 'ナチュラル', 'ハニー', 'アナエロビック', 'カーボニックマセレーション', 'パルプドナチュラル']
    @roast_levels = ['ライトロースト', 'シナモンロースト', 'ミディアムロースト', 'ハイロースト', 'シティロースト', 'フルシティロースト', 'フレンチロースト', 'イタリアンロースト']
    @acidity_levels = ['低', '中低', '中', '中高', '高']
    @body_levels = ['軽い', '中軽', '中', '中重', '重い']
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
    @origins = ['エチオピア', 'ケニア', 'コロンビア', 'ブラジル', 'グアテマラ', 'コスタリカ', 'パナマ', 'ジャマイカ', 'インドネシア', 'ベトナム', 'インド', 'ペルー', 'ボリビア', 'エルサルバドル', 'ホンジュラス', 'ニカラグア', 'メキシコ', 'ハワイ', 'タンザニア', 'ルワンダ']
    @bean_types = ['アラビカ', 'ロブスタ', 'リベリカ', 'ブルボン', 'ティピカ', 'カトゥーラ', 'カツアイ', 'ムンドノーボ', 'パカマラ', 'ゲイシャ', 'エチオピアンヒエラルム', 'ケニアSL28', 'ケニアSL34']
    @process_methods = ['ウォッシュド', 'ナチュラル', 'ハニー', 'アナエロビック', 'カーボニックマセレーション', 'パルプドナチュラル']
    @roast_levels = ['ライトロースト', 'シナモンロースト', 'ミディアムロースト', 'ハイロースト', 'シティロースト', 'フルシティロースト', 'フレンチロースト', 'イタリアンロースト']
    @acidity_levels = ['低', '中低', '中', '中高', '高']
    @body_levels = ['軽い', '中軽', '中', '中重', '重い']
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