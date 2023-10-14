class ArticlesController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :show, :edit]

  def index
    @articles = Article.all
  end

  def new
    #@article = Article.new
  end

  def create
#    render plain: params[:article].inspect
    @article = Article.new article_params

    if @article.valid?
      @article.save
      redirect_to @article#new_article_path
    else
      render action: 'new'
    end
    
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id]) 

# Метод апдейт выполняется валидацию
# автоматически, проверка валид? не требуется
    if article.update article_params
      redirect_to article#new_article_path
    else
      render action: 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.delete

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end


end
