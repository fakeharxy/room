class UsersController < ApplicationController

  def show
    load_user
  end

  private

  def load_user
    @user ||= user_scope.find(params[:id])
  end

  def user_scope
    User.all
  end
end
