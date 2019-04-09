class ProductAd < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  belongs_to :company
end
