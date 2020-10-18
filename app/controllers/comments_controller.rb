class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy,:update]
  before_action :correct_user, only: :destroy

  def create
    @comment=current_user.comments.build(comment_params)
    if @comment.save
      flash.now[:success] = "Comment created!"
      redirect_back(fallback_location: root_path)
    else
      @feed_items = []
    end
  end

  def edit
    @comment=Comment.find(params[:id])
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  def update
    @comment=Comment.find(params[:id])
    @comment.update(comment_params)
    if @comment.update(comment_params)
      flash.now[:success] = "Comment updated"
    else
      render 'edit'
    end
  end

  private
  def comment_params
    params.require(:comment).permit( :content,:commentable_id,:commentable_type)
  end

  def correct_user
    @comment = current_user.comment.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end


end
