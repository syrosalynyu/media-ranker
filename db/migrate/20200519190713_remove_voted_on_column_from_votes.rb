class RemoveVotedOnColumnFromVotes < ActiveRecord::Migration[6.0]
  def change
    remove_column :votes, :voted_on, :date
  end
end
