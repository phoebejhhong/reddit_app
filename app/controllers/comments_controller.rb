class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.commenter_id = params[:commenter_id]
    @comment.post_id = params[:post_id]
    @comment.parent_comment_id = params[:parent_comment_id]

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(params[:post_id])
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :commenter_id, :post_id)
  end
end
