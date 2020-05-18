class ChangeJoinedDateDefaultValueToNil < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :joined, nil
  end
end
