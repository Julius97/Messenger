class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :user_id
      t.boolean :read
      t.integer :conversation_id

      t.timestamps
    end
  end
end
