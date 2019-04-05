class SalesAdsController < ApplicationController
  def new
    @sales_ad = SalesAd.new
  end

  def create
    @sales_ad = SalesAd.new(sales_ad_params)
    @sales_ad.user = current_user
    @sales_ad.save!
    flash[:notice] = 'Anúncio Criado!'
    redirect_to @sales_ad
  end

  def show
    @sales_ad = ProductAd.find(params[:id])
  end

  private

  def sales_ad_params
    params.require(:sales_ad).permit(:title, :description, :price, :usage_time,
                                     :warranty, :expiration_time,
                                     :accepted_rule, :photos)
  end
end
