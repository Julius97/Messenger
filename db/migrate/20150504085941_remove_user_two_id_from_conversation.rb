class RemoveUserTwoIdFromConversation < ActiveRecord::Migration
  def change
    remove_column :conversations, :user_two_id, :integer
  end
end
