class AnswersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  


  def create
    @answer=current_user.answers.build(answer_params)
    if @answer.save
      flash.now[:success] = "Answer created!"
      redirect_back(fallback_location: root_path)
    else
      @feed_items = []
    end
  end


  def edit
    @answer=Answer.find(params[:id])
  end

  def update
    #@answer=Answer.find(params[:id])
    @answer.update(question_params)
    if @answer.update(question_params)
      flash.now[:success] = "Answer updated"
      redirect_to @answer
    else
      render 'edit'
    end
  end

  def destroy
    @answer.destroy
    user=@answer.user
    flash[:success] = "Answer deleted"
    user_rep(user)
    redirect_to request.referrer || root_url
  end
  
  private
  
  def answer_params
    params.require(:answer).permit( :content, :picture,:question_id,:question_id, :user_id)
  end

  def correct_user
    @answer = current_user.answers.find_by(id: params[:id])
    redirect_to root_url if @answer.nil?
  end
  
  

end
