require 'rails_helper'

feature 'seller answer your ad conversations' do
  scenario 'viewing your ads conversations' do
    seller = create(:user, email: 'fabio@campuscode.com', name: 'Fábio')
    buyer = create(:user, email: 'ricardo@campuscode.com', name: 'Ricardo')
    sample_ad = create(:sales_ad, user: seller, title: 'iPhone 5',
                                  company: seller.company)
    conversation = create(:conversation, buyer: buyer, sales_ad: sample_ad)

    seller.confirm
    login_as seller
    visit root_path
    click_on 'Minhas Mensagens'

    expect(page).to have_content('Ricardo - iPhone 5')
    expect(page).to have_link 'Visualizar conversa'
  end

  scenario 'viewing on specify conversation' do
    seller = create(:user, email: 'fabio@campuscode.com', name: 'Fábio')
    buyer = create(:user, email: 'ricardo@campuscode.com', name: 'Ricardo')
    sample_ad = create(:sales_ad, user: seller, title: 'iPhone 5',
                                  company: seller.company)
    conversation = create(:conversation, buyer: buyer, sales_ad: sample_ad)
    first_message = create(:message, user: buyer, conversation: conversation,
                                     body: 'Ainda está disponível?')
    second_message = create(:message, user: buyer, conversation: conversation,
                                     body: 'Preciso Urgente!')
    
    seller.confirm
    login_as seller
    visit conversations_path
    click_on 'Visualizar conversa'

    expect(page).to have_css('h1', text: 'Ricardo - iPhone 5')
    expect(page).to have_content "#{buyer.name} diz:"
    expect(page).to have_content 'Ainda está disponível?'
    expect(page).to have_content 'Preciso Urgente!'
    expect(page).to have_button 'Enviar'
  end
end