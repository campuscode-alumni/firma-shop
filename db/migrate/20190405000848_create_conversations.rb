class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :sales_ad, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
