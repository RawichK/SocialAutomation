class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    params[:user] = @user
    @folNum = Instagram.user_follows.length
  end
  
  def new
  end
end
