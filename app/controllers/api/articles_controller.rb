class Api::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :new, :update]
  before_action :cannot_edit_others_articles, only: [:edit]
  before_action :cannot_destroy_others_articles, only: [:destroy]

  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created, location: api_articles_url(@article)
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :content).merge(user_id: current_user.id)
    end

    def cannot_edit_others_articles
      @article = Article.find(params[:id])
      if current_user
        if current_user.id != @article.user.id 
          render json: "Vous ne pouvez pas éditer un article ne vous appartenant pas"
        end
      else
        render json: "Vous ne pouvez pas éditer un article sans être connecté"
      end
    end
  
    def cannot_destroy_others_articles
      @article = Article.find(params[:id])
      if current_user
        if current_user.id != @article.user.id 
          render json: "Vous ne pouvez pas supprimer un article ne vous appartenant pas"
        end
      else
        render json: "Vous ne pouvez pas supprimer un article sans être connecté"
      end
    end
end
