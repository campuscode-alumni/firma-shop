require 'rails_helper'

feature 'user view company page' do
  scenario 'and view ads from your company' do
    company = create(:company, name: 'Google', domain: 'google.com')
    user = create(:user, email: "fabio@#{company.domain}")
    first_ad = create(:sales_ad, user: user, title: 'iPhone 5',
                                 company: company)
    second_ad = create(:sales_ad, user: user, title: 'iPhone 5',
                                  company: company)
    user.confirm

    login_as user
    visit root_path

    expect(page).to have_css('a', text: company.name)
    expect(page).to have_css('div', text: first_ad.title)
    expect(page).to have_css('div', text: second_ad.title)
    expect(page).to have_css('img[src*="default_ad"]')
  end

  scenario 'and not view ads from other companies' do
    first_company = create(:company, name: 'Google', domain: 'google.com')
    second_company = create(:company, name: 'Amazon', domain: 'amazon.com')
    user_from_first_company = create(
      :user, email: "fabio@#{first_company.domain}"
    )
    user_from_second_company = create(
      :user, email: "luis@#{second_company.domain}"
    )
    ad_from_first_company = create(:sales_ad, user: user_from_first_company,
                                              title: 'iPhone 5',
                                              company: first_company)
    ad_from_second_company = create(:sales_ad, user: user_from_second_company,
                                               title: 'Computador',
                                               company: second_company)
    user_from_first_company.confirm

    login_as user_from_first_company
    visit root_path

    expect(page).to have_css('a', text: first_company.name)
    expect(page).to have_css('div', text: ad_from_first_company.title)
    expect(page).not_to have_content(ad_from_second_company.title)
  end

  scenario 'and access ad from company page' do
    company = create(:company, name: 'Google', domain: 'google.com')
    user = create(
      :user, email: "fabio@#{company.domain}"
    )
    sample_ad = create(:sales_ad, user: user, title: 'iPhone 5',
                                  company: company)
    user.confirm

    login_as user
    visit root_path
    click_on sample_ad.title

    expect(current_path).to eq(sales_ad_path(sample_ad))
  end
  scenario 'does not view inactive ads' do
    company = create(:company, name: 'Firma Shop', domain: 'firmashop.com')
    seller = create(:user, name: 'Seller', email: 'seller@firmashop.com',
                           company: company)
    seller.confirm
    sale_ads = create(:sales_ad, user: seller, ad_state: 1, company: company)
    user = create(:user, name: 'Buyer', email: 'buyer@firmashop.com',
                         company: company)
    user.confirm

    login_as user
    visit root_path

    expect(page).not_to have_css('a', text: sale_ads.title)
  end
end
