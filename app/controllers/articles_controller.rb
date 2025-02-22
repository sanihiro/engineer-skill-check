class ArticlesController < ApplicationController
  before_action :set_article, only: %i(edit update destroy show)

  def index
    @articles = Article.active.order("#{sort_column} #{sort_direction}")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path, notice: "お知らせを投稿しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @article.update(article_params)
      redirect_to articles_path, notice: "お知らせを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      now = Time.now
      @article.update_column(:deleted_at, now)
    end

    redirect_to articles_path, notice: "お知らせを削除しました。"
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end

  def set_article
    @article = Article.find(params["id"])
  end


  def sort_column
    params[:sort] ? params[:sort] : 'created_at'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'asc'
  end

end
