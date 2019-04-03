require 'rails_helper'

feature 'User login' do
  scenario 'successfully' do
    user = create(:user)
    user.confirm
    expect(user.expiration_date).to eq(Time.zone.today + 90.days)
    expect(user.active?).to be_truthy
  end
end
