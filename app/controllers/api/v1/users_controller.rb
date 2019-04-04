class Api::V1::UsersController < Api::V1::ApplicationController
  def index
    @users = User.all
    render status: 200, json: @users
  end

  def destroy
    @user = User.find_by(id: params[:id])
    return render status: 404, json: "User ##{params[:id]} does exist" unless @user
    @user.destroy
    render status: 200, json: 'ok'
  end
end