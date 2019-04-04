FactoryBot.define do
  factory :sales_ad do
    title { 'Bola Quadrada' }
    description { 'Incrível bola quadrada!' }
    price { '9.99' }
    usage_time { 10 }
    warranty { true }
    expiration_time { 30 }
    accepted_rule { true }
    user 
  end
end
