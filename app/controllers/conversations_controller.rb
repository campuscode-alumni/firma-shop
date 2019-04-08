class ConversationsController < ApplicationController
  def create
    sales_ad = SalesAd.find(params[:id])
    Conversation.create(sales_ad: sales_ad, buyer: current_user)
    redirect_to sales_ad
  end
end
