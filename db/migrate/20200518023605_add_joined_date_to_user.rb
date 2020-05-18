class AddJoinedDateToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :joined, :date
  end
end
