class AddUserToProductAd < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_ads, :user, foreign_key: true
  end
end
