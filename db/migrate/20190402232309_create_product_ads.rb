class CreateProductAds < ActiveRecord::Migration[5.2]
  def change
    create_table :product_ads do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :usage_time
      t.boolean :warranty
      t.integer :expiration_time
      t.boolean :accepted_rule

      t.timestamps
    end
  end
end
