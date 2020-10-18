class Comment < ApplicationRecord
  belongs_to :commentable , polymorphic: true
  belongs_to :user, inverse_of: :comments

  validates :content, presence: true, length: {maximum: 100}
end
