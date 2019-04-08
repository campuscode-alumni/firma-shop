require 'rails_helper'

feature 'User create a sales ad' do
  scenario 'successfully' do
    # arrange
    user = create(:user)
    user.confirm
    # act
    login_as user, scope: :user
    visit root_path
    click_on 'Inserir Anúncio'

    within '#sales_form' do
      fill_in 'Título', with: 'Bola Quadrada'
      fill_in 'Descrição', with: 'Bola Quadrada pouco tempo de uso, única!'
      attach_file 'Foto',
                  [Rails.root.join('spec', 'support', 'bola_quadrada.jpg'),
                   Rails.root.join('spec', 'support', 'bola_quadrada2.jpg')]
      fill_in 'Preço', with: '100.99'
      select '10', from: 'Tempo de uso'
      check 'Garantia'
      select '15 Dias', from: 'Duração do anúncio'
      check 'Li e concordo com as regras da plataforma.'
      click_on 'Criar Anúncio'
    end
    # assert
    expect(ProductAd.last.type).to eq 'SalesAd'
    expect(page).to have_content 'Anúncio Criado!'
    expect(page).to have_content 'Bola Quadrada'
    expect(page).to have_content 'Bola Quadrada pouco tempo de uso, única!'
    expect(page).to have_content 'R$ 100,99'
    expect(page).to have_content '10 meses'
    expect(page).to have_content 'Garantia: Sim'
    expect(page).to have_content 'Expiração do anúncio: 15 dias'
  end

  scenario 'and any field could be blank' do
    # arrange
    user = create(:user)
    user.confirm
    # act
    login_as user, scope: :user
    visit root_path
    click_on 'Inserir Anúncio'

    within '#sales_form' do
      fill_in 'Título', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Preço', with: ''
      check 'Garantia'
      click_on 'Criar Anúncio'
    end
    # assert
    expect(page).to have_content('Não foi possível criar o anúncio')
  end
end
