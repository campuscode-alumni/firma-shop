class Company < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :sales_ads, dependent: :restrict_with_error
end
