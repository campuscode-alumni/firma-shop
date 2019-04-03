require 'rails_helper'

feature 'User login' do
  scenario 'successfully' do
    user = create(:user)
    user.confirm
    login_as user, scope: :user
    visit root_path

    expect(user.expiration_date.strftime("%d/%m/%Y")).to eq(
      (Date.today + 90).to_time.strftime("%d/%m/%Y")
    )
    expect(user.active?).to be_truthy
    expect(current_path).to eq(root_path)
  end
end