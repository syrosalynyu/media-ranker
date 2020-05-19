class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :votes
  has_many :works, through: :votes
end
