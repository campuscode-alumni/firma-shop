class AddExpirationDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :expiration_date, :datetime
  end
end
