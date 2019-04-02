require 'rails_helper'

feature 'User create account' do
  scenario 'successfully' do
    email = 'edu.costa@campuscode.com'
    visit root_path

    click_on 'Cadastrar-se'
    fill_in 'Nome', with: 'Eduardo Costa'
    fill_in 'Email', with: email
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'

    user = User.find_by(email: email)
    expect(user).to be_present
    expect(user).not_to be_confirmed
  end

  scenario 'and save company' do
    company_domain = 'campuscode.com'
    email = "edu.costa@#{company_domain}"
    visit root_path

    click_on 'Cadastrar-se'
    fill_in 'Nome', with: 'Eduardo Costa'
    fill_in 'Email', with: email
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'

    expect(Company.count).to eq(1)
    expect(Company.find_by(domain: company_domain)).to be_present
    expect(User.find_by(email: email).company.domain).to eq(company_domain)
  end

  scenario 'without name' do
    email = 'edu.costa@campuscode.com'
    visit root_path

    click_on 'Cadastrar-se'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: email
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'

    expect(Company.find_by(domain: 'campuscode.com')).not_to be_present
    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
