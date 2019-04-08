class Api::V1::ProductAdsController < Api::V1::ApplicationController
  def index
    @product_ads = ProductAd.all
    render status: :ok, json: @product_ads
  end

  def destroy
    @product_ads = ProductAd.find_by(id: params[:id])
    if @recipe
      @recipe.destroy
      render status: :ok, json: 'Recipe Deleted'
    end
    render status: :not_found, json: 'Product ad not found'
  end
end
