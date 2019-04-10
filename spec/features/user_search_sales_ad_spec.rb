require 'rails_helper'

feature 'User search ads' do
  scenario 'ads search successfully' do
    company = create(:company, name: 'Google', domain: 'google.com')
    seller = create(:user, email: "fabio@#{company.domain}")
    sales_ad_a = create(:sales_ad, user: seller, title: 'iPhone 5',
                                   description: 'Incrível iphone 5 com 128GB',
                                   company: company)
    sales_ad_b = create(:sales_ad, user: seller, title: 'Computador',
                                   company: company)
    user = create(:user, email: "jorge@#{company.domain}")
    user.confirm

    login_as user
    visit root_path
    fill_in 'Buscar', with: 'iPhone 5'
    click_on 'Buscar'

    expect(page).to have_css('p', text: '1')
    expect(page).to have_css('h1', text: company.name)
    expect(page).to have_css('h2', text: sales_ad_a.title)
    expect(page).to_not have_content(sales_ad_b.title)
  end
  scenario 'ads search by a therm' do
    company = create(:company, name: 'Google', domain: 'google.com')
    seller = create(:user, email: "fabio@#{company.domain}")
    sales_ad_a = create(:sales_ad, user: seller, title: 'iPhone 5',
                                   description: 'Incrível iphone 5 com 128GB',
                                   company: company)
    sales_ad_b = create(:sales_ad, user: seller, title: 'Computador',
                                   company: company)
    user = create(:user, email: "jorge@#{company.domain}")
    user.confirm

    login_as user
    visit root_path
    fill_in 'Buscar', with: 'Incrível'
    click_on 'Buscar'

    expect(page).to have_css('p', text: '2')
    expect(page).to have_css('h2', text: sales_ad_a.title)
    expect(page).to have_css('h2', text: sales_ad_b.title)
  end
  scenario 'ads dont exist' do
    company = create(:company, name: 'Google', domain: 'google.com')
    seller = create(:user, email: "fabio@#{company.domain}")
    create(:sales_ad, user: seller, title: 'iPhone 5',
                      description: 'Incrível iphone 5 com 128GB',
                      company: company)
    create(:sales_ad, user: seller, title: 'Computador', company: company)
    user = create(:user, email: "jorge@#{company.domain}")
    user.confirm

    login_as user
    visit root_path
    fill_in 'Buscar', with: 'Notebook'
    click_on 'Buscar'

    expect(page).to have_css('p', text: 'Ops.. Nenhum resultado encontrado')
  end
end
