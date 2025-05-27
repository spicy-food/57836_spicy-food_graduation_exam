class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:user).page(params[:page]).per(20)
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: '記事が正常に作成されました'
    else
      flash.now[:alert] = '記事の作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end 