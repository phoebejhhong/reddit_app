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

  def upvote
    vote = Vote.new(value: 1, voter_id: current_user.id,
    votable_type: 'Comment', votable_id: params[:comment_id])
    if vote.save
      redirect_to comment_url(vote.votable)
    else
      flash[:errors] = vote.errors.full_messages
      redirect_to comment_url(vote.votable)
    end
  end

  def downvote
    vote = Vote.new(value: -1, voter_id: current_user.id,
    votable_type: 'Comment', votable_id: params[:comment_id])
    if vote.save
      redirect_to comment_url(vote.votable)
    else
      flash[:errors] = vote.errors.full_messages
      redirect_to comment_url(vote.votable)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :commenter_id, :post_id)
  end
end
