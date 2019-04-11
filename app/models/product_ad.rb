class ProductAd < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  belongs_to :company
  enum ad_state: { active: 0, inactive: 1 }

  def owner?(user)
    self.user.eql? user
  end
end
