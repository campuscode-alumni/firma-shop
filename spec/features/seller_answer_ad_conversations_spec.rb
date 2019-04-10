require 'rails_helper'

feature 'seller answer your ad conversations' do
  scenario 'viewing your ads conversations' do
    seller = create(:user, email: 'fabio@campuscode.com', name: 'Fábio')
    buyer = create(:user, email: 'ricardo@campuscode.com', name: 'Ricardo')
    sample_ad = create(:sales_ad, user: seller, title: 'iPhone 5',
                                  company: seller.company)
    create(:conversation, buyer: buyer, sales_ad: sample_ad)

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
    create(:message, user: buyer, conversation: conversation,
                     body: 'Ainda está disponível?')
    create(:message, user: buyer, conversation: conversation,
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

  scenario 'answer one conversation' do
    seller = create(:user, email: 'fabio@campuscode.com', name: 'Fábio')
    buyer = create(:user, email: 'ricardo@campuscode.com', name: 'Ricardo')
    sample_ad = create(:sales_ad, user: seller, title: 'iPhone 5',
                                  company: seller.company)
    conversation = create(:conversation, buyer: buyer, sales_ad: sample_ad)
    create(:message, user: buyer, conversation: conversation,
                     body: 'Ainda está disponível?')
    create(:message, user: buyer, conversation: conversation,
                     body: 'Preciso Urgente!')

    seller.confirm
    answer_message = 'Já foi vendido.'
    login_as seller

    visit conversation_path(conversation)
    fill_in 'Mensagem', with: answer_message
    click_on 'Enviar'

    expect(conversation.messages.where(user: seller)).to be_present
    expect(conversation.messages.last.body).to eq(answer_message)
  end

  scenario 'dont sent messages for your ads' do
    seller = create(:user, email: 'fabio@campuscode.com', name: 'Fábio')
    sample_ad = create(:sales_ad, user: seller, title: 'iPhone 5',
                                  company: seller.company)

    seller.confirm
    login_as seller

    visit sales_ad_path(sample_ad)

    expect(page).not_to have_content 'Tenho interesse'
  end
end
