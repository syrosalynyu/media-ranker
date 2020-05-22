class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :votes, dependent: :destroy 
  has_many :works, through: :votes
end
