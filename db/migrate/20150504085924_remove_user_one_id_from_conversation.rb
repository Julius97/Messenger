class RemoveUserOneIdFromConversation < ActiveRecord::Migration
  def change
    remove_column :conversations, :user_one_id, :integer
  end
end
