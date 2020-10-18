module Votable
  extend ActiveSupport::Concern
  included do
    has_many  :vote, as: :votable, dependent: :destroy
  end
end