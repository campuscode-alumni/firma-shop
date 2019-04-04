require 'rails_helper'

RSpec.describe SalesAd, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:usage_time) }
  it { should validate_presence_of(:warranty) }
  it { should validate_presence_of(:expiration_time) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:type) }
  it { should validate_acceptance_of(:accepted_rule) }
end
