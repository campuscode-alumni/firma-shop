require 'rails_helper'

RSpec.describe 'Product Ads API', type: :request do
  describe 'list sales ads' do
    it 'should list all sales ads' do
      user1 = create(:user, email: 'user1@email.com')
      user2 = create(:user, email: 'user2@email.com')

      product_ad = create(:product_ad, title: 'Anuncio 1', user_id: user1)
      product_ad = create(:product_ad, title: 'Anuncio 2', user_id: user2)

      get '/api/v1/product_ads'

      expect(response.status).to eq 200
      # expect(responde).to have_http_status(:success)
      expect(response.body).to include 'Anuncio 1'
      expect(response.body).to include 'Anuncio 2'

    end

    it 'delete a product that does not exist' do
      delete '/api/v1/product_ads/999'

      expect(response.status).to eq 404
      expect(response.body).to include 'Product ad not found'
    end
  end

end