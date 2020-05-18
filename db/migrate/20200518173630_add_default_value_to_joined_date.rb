class AddDefaultValueToJoinedDate < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :joined, Date.today
  end
end
