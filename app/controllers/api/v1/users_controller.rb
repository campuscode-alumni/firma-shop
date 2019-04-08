class Api::V1::UsersController < Api::V1::ApplicationController
  def index
    @users = User.all
    render status: :ok, json: @users
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user
      @user.destroy
      render status: :ok, json: 'ok'
    else
      render status: :not_found, json: "User ##{params[:id]} does exist"
    end
  end
end
