class AddAdStateToProductAd < ActiveRecord::Migration[5.2]
  def change
    add_column :product_ads, :ad_state, :integer, default: 0
  end
end
