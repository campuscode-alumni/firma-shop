class AddTypeToProductAd < ActiveRecord::Migration[5.2]
  def change
    add_column :product_ads, :type, :string
  end
end
