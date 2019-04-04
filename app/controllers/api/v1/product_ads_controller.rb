class Api::V1::ProductAdsController < Api::V1::ApplicationController
  def index
    @product_ads = ProductAd.all
    render status:200, json: @product_ads
  end

  def destroy
    @product_ads = ProductAd.find_by(id: params[:id])
    if @recipe
      @recipe.destroy
      render status: 200, json: 'Recipe Deleted'
    end
    render status: 404, json: 'Product ad not found'
  end

end