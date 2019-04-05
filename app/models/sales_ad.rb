class SalesAd < ProductAd
  has_many_attached :photos
  validates :title, :description, :price, :usage_time, :warranty,
            :expiration_time, :user_id, :type, presence: true
  validates :accepted_rule, acceptance: true
end
