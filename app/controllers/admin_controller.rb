class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
  end

  def users
    @users = User.all
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.toggle_admin!

    respond_to do |format|
      format.html { redirect_to user_management_path, notice: "#{@user.profile.full_name}'s admin status has successfully been modified" }
    end
  end
end
