class TagsController < ApplicationController
  def show
    @tags=Tag.find(params[:id])
    @question = @tags.questions
  end

  def index
    @tags=Tag.all.paginate(page: params[:page])
  end
end
