class Work < ApplicationRecord
  CATEGORIES = %w(album book movie).freeze # I can call this constant variable in views to keep my code DRY
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  # Q: how to change it so that each category can have the same name once?
  # Answer from my tutor Jordan: use scope
  validates :title, presence: true, uniqueness: { case_sensitive: false, scope: :category }

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

  # Talked to my tutor Jordan to come up with this solution
  def self.work_by_votes(category, limit = nil) # limit = 10 can show the top-ten
    work_list = Work.where(category: category)
    # .joins will only return works that have votes; .left_join will return all of the works regardless of how many votes they got
    # STEPS: join the tables > group the items > decending order bases on the counts of votes.
    work_list = work_list.left_joins(:votes).group("works.id").order("COUNT(votes.id) DESC")
    work_list = work_list.limit(limit) unless limit.nil?
    work_list
  end
end
