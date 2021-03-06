require 'rails_helper'

feature 'should create one chat' do
  scenario 'create a conversation' do
    buyer = create(:user, email: 'fabio@campuscode.com', name: 'Fabio')
    buyer.confirm
    seller = create(:user, name: 'Joao')
    login_as buyer
    advertisement = create(:sales_ad, user: seller, company: seller.company)

    visit sales_ad_path(advertisement)
    click_on 'Tenho interesse'

    expect(Conversation.count).to eq 1
    expect(page).to have_content 'Conversa com Joao'
    expect(page).to have_button 'Enviar'
    expect(page).to_not have_link 'Tenho interesse'
  end

  scenario 'buyer send a message' do
    buyer = create(:user, email: 'fabio@campuscode.com', name: 'Fabio')
    buyer.confirm
    seller = create(:user, name: 'Joao')
    advertisement = create(:sales_ad, user: seller, company: seller.company)

    login_as buyer
    visit sales_ad_path(advertisement)
    click_on 'Tenho interesse'
    fill_in 'message[body]', with: 'Olá João o valor pode ser parcelado?'
    click_on 'Enviar'

    expect(page).to have_content('Olá João o valor pode ser parcelado?')
    expect(page).to have_content("#{buyer.name} diz:")
  end

  scenario 'buyer send a message nil' do
    buyer = create(:user, email: 'fabio@campuscode.com', name: 'Fabio')
    buyer.confirm
    seller = create(:user, name: 'Joao')
    advertisement = create(:sales_ad, user: seller, company: seller.company)

    login_as buyer
    visit sales_ad_path(advertisement)
    click_on 'Tenho interesse'
    fill_in 'message[body]', with: ''
    click_on 'Enviar'

    expect(page).to_not have_css('div.message')
  end
end
