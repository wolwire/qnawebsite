class StaticPagesController < ApplicationController
  def home
    if current_user
      @questions = current_user.questions.paginate(page: params[:page])
    end
  end

  def help

  end

  def about

  end

  def contact

  end

end
