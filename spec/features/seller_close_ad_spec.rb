require 'rails_helper'

feature 'Seller close ad' do
  scenario 'view sales ads status' do
    seller = create(:user, name: 'Seller', email: 'seller@firmashop.com')
    seller.confirm
    company = create(:company, name: 'Firma Shop', domain: 'firmashop.com')
    sale_ads = create(:sales_ad, user: seller, ad_state: 0, company: company)

    login_as seller
    visit sales_ad_path(sale_ads)

    expect(page).to have_css('span', text: 'Ativo')
  end

  scenario 'and inactive advertisement' do
    seller = create(:user, name: 'Seller', email: 'seller@firmashop.com')
    seller.confirm
    company = create(:company, name: 'Firma Shop', domain: 'firmashop.com')
    sale_ads = create(:sales_ad, user: seller, ad_state: 0, company: company)

    login_as seller
    visit sales_ad_path(sale_ads)
    click_on 'Inativar este anuncio'

    expect(page).to have_css('span', text: 'Inativo')
    expect(page).not_to have_css('a', text: 'Inativar este anuncio')
  end

  scenario 'and not view conversation' do
    seller = create(:user, name: 'Seller', email: 'seller@firmashop.com')
    seller.confirm
    company = create(:company, name: 'Firma Shop', domain: 'firmashop.com')
    sale_ads = create(:sales_ad, user: seller, ad_state: 1, company: company)
    user = create(:user, name: 'Buyer', email: 'buyer@firmashop.com')
    conversation = create(:conversation, sales_ad: sale_ads, buyer: user)
    message = create(:message, conversation: conversation, user: user,
                               body: 'Olá estou interessado')
    login_as user
    visit sales_ad_path(sale_ads)

    expect(page).not_to have_content(message.body)
  end
end
