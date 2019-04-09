class AddCompanyToProductAds < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_ads, :company, foreign_key: true
  end
end
