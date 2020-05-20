class Work < ApplicationRecord
  validates :category, inclusion: { in: %w(album book movie) }
  # TODO: how to change it so that each category can have the same name once?
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many :votes
  has_many :users, through: :votes

  def self.highest_vote
    vote_chart ={}

    # Online resource: refer to https://engineering.gusto.com/a-visual-guide-to-using-includes-in-rails/
    Work.includes(:votes).map do |work|
      vote_chart[work] = work.votes.size
    end
    
    highest_vote = vote_chart.values.max
    return [vote_chart.key(highest_vote), highest_vote]
  end

  # TODO
  def self.works_by_vote(category)
    work_list = Work.where(category: category)
    vote_chart ={}

    work_list.each do |work|
      vote_chart[work] = work.votes.size
    end
    # TODO: I don't think this return what I want
    return work_list.includes(:vote).order("votes.size DESC")
  end

  # TODO
  def self.top_ten
    
  end
end
