FactoryBot.define do
  factory :product_ad do
    title { 'Bola Quadrada' }
    description { 'Incrível bola quadrada!' }
    price { '9.99' }
    usage_time { 10 }
    warranty { false }
    expiration_time { 30 }
    accepted_rule { true }
  end
end
