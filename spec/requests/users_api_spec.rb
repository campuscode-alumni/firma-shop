require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'list users' do
    it 'should list all users' do
      first_user = create(:user, email: 'fatima@ig.com', name: 'Fatima')
      second_user = create(:user, email: 'joao@uol.com.br', name: 'João')

      # chamada p/ API
      get '/api/v1/users'

      # expectativas
      expect(response.status).to eq 200
      expect(response).to have_http_status(:success)
      expect(response.body).to include 'João'
      expect(response.body).to include 'Fatima'
    end
  end

  describe 'delete an users' do
    it 'should delete an specify user' do
      
      delete '/api/v1/users/999'

      expect(response.status).to eq 404
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include 'User #999 does exist'
    end
  end
end