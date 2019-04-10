FactoryBot.define do
  factory :message do
    conversation
    user
    body { 'Isso está disponível?' }
  end
end
