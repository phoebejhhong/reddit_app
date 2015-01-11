class SubsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.friendly.find(params[:id])
  end

  def edit
    @sub = Sub.friendly.find(params[:id])
  end

  def update
    @sub = Sub.friendly.find(params[:id])
    if @sub.moderator_id != current_user.id
      flash[:error] = "You can't edit other people's subreddits!"
      redirect_to sub_url(@sub)
    elsif @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

end
