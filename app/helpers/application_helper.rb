module ApplicationHelper
  def full_title(page_title = '')
    base_title = "stackoverflow"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def user_rep(user)
    s=0
    user.questions.each do |question|
      s += question.votes_rep
    end
    user.answers.each do |answer|
      s += answer.votes_rep
    end
    user.update(reputation: s)
  end


end
