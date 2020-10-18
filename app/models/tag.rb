class Tag < ApplicationRecord
  has_and_belongs_to_many :questions
  validates :name , presence: true , length: {maximum: 50}, uniqueness: {case_sensitive: false}
end
