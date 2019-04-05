class Conversation < ApplicationRecord
  belongs_to :sales_ad
  belongs_to :buyer, class_name: 'User', foreign_key: 'user_id'

  def seller
    sales_ad.user
  end
end
