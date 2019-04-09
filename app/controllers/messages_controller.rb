class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.conversation = @conversation
    @message.save
    redirect_to @conversation.sales_ad
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
