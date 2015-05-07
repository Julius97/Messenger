class AddContactIdToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :contact_id, :integer
  end
end
