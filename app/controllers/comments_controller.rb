class CommentsController < ApplicationController

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params) 
        redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:comment_id])
        @comment.destroy
        redirect_to article_path(@article), status: :see_other
    end

    private
    def comment_params
        params.require(:comment).permit( :commenter, :content, :status)
    end
end
