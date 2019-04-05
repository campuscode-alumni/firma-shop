require 'rails_helper'

feature 'should create one chat' do

    scenario 'create a conversation' do
      pending
      buyer = create(:user, email: 'fabio@campuscode.com', name: 'Fabio')
      buyer.confirm
      seller = create(:user, name: 'Joao')
      login_as buyer
      advertisement = create(:sales_ad, user: seller)

      visit sales_ad_path(advertisement)
      click_on 'Tenho interesse'

      expect(Conversation.count).to eq 1
      expect(page).to have_content 'Conversa com Joao'
      expect(page).to have_field 'Mensagem'
      expect(page).to have_button 'Enviar'
      expect(page).to_not have_link 'Tenho interesse'
    end
end