class QuestionsController < ApplicationController
  include QuestionsHelper
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy


  def index
    @questions=Question.all.paginate(page: params[:page])
  end

  def new
    @question=Question.new
  end

  def create
    @question=current_user.questions.build(question_params)
    add_tags(params[:tags][:tags])
    if @question.save

      flash[:success] = "Question created!"
      redirect_to @question
    else
      @feed_items = []
      redirect_to new_question_path
    end
  end

  def search
    @questions = search_ques(params[:search])
    if  @questions.empty?
      flash[:info] = "Couldn\'t find #{params[:search]}"
    else
      @questions = @questions.paginate(page: params[:page])
    end
  end



  def show
    @question=Question.find(params[:id])
    @answers=@question.answers
    @tags=@question.tags
  end



  def edit
    @question=Question.find(params[:id])
  end



  def update
    @question=Question.find(params[:id])
    @question.update(question_params)
    if @question.update(question_params)
      flash[:success] = "Question updated"
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    puts "hello"
    user=@question.user
    @question.destroy
    user_rep(user)
    flash[:success] = "Question deleted"
    redirect_to  root_url
  end



  private

  def add_tags(args)
    args = args.split(" ")
    args.each do |arg|
      tag=Tag.find_by(name: arg)
      if tag.nil?
        @question.tags<<Tag.create(name:arg)
      else
        @question.tags<<tag
      end
    end
  end

  def question_params
    params.require(:question).permit(:header, :content, :picture)
  end

  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    redirect_to root_url if @question.nil?
  end

end
