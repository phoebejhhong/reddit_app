class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def new
    @post = Post.new
    @post.sub_ids = [params[:sub_id]]
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_ids = params[:post][:sub_ids]

    if @post.sub_ids.empty?
      flash[:errors] = "You need to assign a subreddit"
      render :new
    elsif @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.sub_ids = params[:post][:sub_ids]
    if @post.author_id != current_user.id
      flash[:error] = "You can't edit other people's posts!"
      redirect_to post_url(@post)
    elsif @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def index
    @posts = post.all
  end

  def upvote
    vote = Vote.new(value: 1, voter_id: current_user.id,
                  votable_type: 'Post', votable_id: params[:post_id])
    if vote.save
      redirect_to post_url(vote.votable)
    else
      flash[:errors] = vote.errors.full_messages
      redirect_to post_url(vote.votable)
    end
  end

  def downvote
    vote = Vote.new(value: -1, voter_id: current_user.id,
                    votable_type: 'Post', votable_id: params[:post_id])
    if vote.save
      redirect_to post_url(vote.votable)
    else
      flash[:errors] = vote.errors.full_messages
      redirect_to post_url(vote.votable)
    end
  end

  # def destroy
  #   @post = Post.find(params[:id])
  #   if @post.author_id != current_user.id
  #     flash[:error] = "You can't delete other people's posts!"
  #     redirect_to post_url(@post)
  #   else
  #     @post.destroy
  #     redirect_to sub_url(@post.sub)
  #   end
  # end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end


end
