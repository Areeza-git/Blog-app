class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_article, only: [:edit, :update, :destroy]

    include Pundit::Authorization

    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = current_user.articles.build
    end

    def create
        @article  = current_user.articles.build(article_params)

        if @article.save
            redirect_to @article, notice: 'Article was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit 
        authorize @article
    end

    def update
       authorize @article
        if @article.update(article_params)
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        authorize @article
        if @article.destroy
            redirect_to root_path status: :see_other
        else
            redirect_to @article, alert: 'An error occurred while deletion.'
        end
    end

    private

    def article_params
        params.require(:article).permit(:title, :description, :status)
    end

    def set_article
        @article = Article.find(params[:id])
    end
end
