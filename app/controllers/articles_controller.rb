class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    if current_user
      @articles = current_user.organization.articles
    else
      # Handle the case where the user is not authenticated
      redirect_to new_user_session_path, alert: 'You need to sign in to access this page.'
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    @article.organization = current_user.organization

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end


  private
  def set_article
    # Ensure that the article belongs to the current organization
    @article = current_user.organization.articles.find(params[:id])
  end


  def authorize_user!
    unless @article.user == current_user
      flash[:alert] = "You are not authorized to edit or delete this article."
      redirect_to articles_path
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :status, :organization_id)
  end
end
