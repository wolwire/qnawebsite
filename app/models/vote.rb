class Vote < ApplicationRecord
  belongs_to :votable ,polymorphic: true, inverse_of: :vote
  belongs_to :user, inverse_of: :votes
  validates :user_id , :uniqueness => { :scope => [:votable_type, :votable_id] }

  def upvote
    if self.vote==true
      update(vote: nil )
       -1
    else
      update(vote: true)
       1
    end
  end

  def downvote
    if self.vote==false
      update(vote: nil )
       -1
    else
      update(vote: false)
      1
    end
  end

end
