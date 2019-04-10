class ConversationsController < ApplicationController
  def create
    sales_ad = SalesAd.find(params[:id])
    Conversation.create(sales_ad: sales_ad, buyer: current_user)
    redirect_to sales_ad
  end

  def index
    @conversations = Conversation.where(sales_ad: current_user.sales_ads)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end
end
