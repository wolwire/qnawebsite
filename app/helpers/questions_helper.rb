module QuestionsHelper
  def search_ques(search_string)
    Question.where("header LIKE ? ", "%#{search_string}%")
  end
end
