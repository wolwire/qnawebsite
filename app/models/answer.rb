class Answer < ApplicationRecord
  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers
  include Commentable, Votable

  validates :content, presence: true, length: {maximum: 30000,too_long: "%{count} characters is the maximum allowed" }

  def upvote
    increment(:votes_rep,1)
  end

  def downvote
    decrement(:votes_rep,1)
  end

  private
  def picture_size
    if picture.size>5.megabyte
      errors.add(:picture , "should be less than 5MB")
    end
  end


end
