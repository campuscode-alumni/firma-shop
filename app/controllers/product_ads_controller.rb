class ProductAdsController < ApplicationController
  def new
    @sales_ad = SalesAd.new
  end

  def create_sales_ad
    @user = current_user
    @sales_ad = SalesAd.new(sales_ad_params)
    @sales_ad.user = @user
    if @sales_ad.save
      flash[:notice] = 'Anúncio Criado!'
      redirect_to product_ad_path(@sales_ad)
    else
      flash[:notice] = 'Não foi possível criar o anúncio'
      render :new
    end

  end

  def show
    @product_ad = ProductAd.find(params[:id])
  end

  private

  def sales_ad_params
    params.require(:sales_ad).permit(:title, :description, :price, :usage_time,
                                     :warranty, :expiration_time,
                                     :accepted_rule, :photos)
  end
end
