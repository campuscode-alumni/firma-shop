class SalesAdsController < ApplicationController
  def new
    @sales_ad = SalesAd.new
  end

  def create
    @sales_ad = SalesAd.new(sales_ad_params)
    @sales_ad.user = current_user
    @sales_ad.company = current_user.company

    if @sales_ad.save
      flash[:notice] = 'Anúncio Criado!'
      redirect_to @sales_ad
    else
      flash[:notice] = 'Não foi possível criar o anúncio'
      render :new
    end
  end

  def show
    @sales_ad = ProductAd.find(params[:id])
    @conversation = Conversation.find_by(sales_ad: @sales_ad,
                                         buyer: current_user)
    @message = @conversation.messages.build if @conversation
  end

  private

  def sales_ad_params
    params.require(:sales_ad).permit(:title, :description, :price, :usage_time,
                                     :warranty, :expiration_time,
                                     :accepted_rule, photos: [])
  end
end
