class Work < ApplicationRecord
  validates :category, inclusion: { in: %w(album book movie) }
  # TODO: how to change it so that each category can have the same name once?
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
