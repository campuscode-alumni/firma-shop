class SalesAd < ProductAd
  has_many :conversations
  validates :title, :description, :price, :usage_time,
            :expiration_time, :type, presence: true
  validates :accepted_rule, acceptance: true
end
