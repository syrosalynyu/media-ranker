class AddColumnVotedOnToVotesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :voted_on, :date
  end
end
