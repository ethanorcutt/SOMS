class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user

  # GET to /users/:user_id/profiles/new
  def new
    # Render a blank profiles details form
    @profile = Profile.new
  end

  # POST to /users/:user_id/profiles
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find( params[:user_id] )
    #Create profiles linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile Created!"
      redirect_to user_path( id: params[:user_id] )
    else
      render action: :new
    end
  end

  # GET to /users/:user_id/profiles/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end

  # PATCH to /users/:user_id/profiles
  def update
    # Retrieve the user from the database
    @user = User.find( params[:user_id] )
    # Retrive that user's profiles
    @profile = @user.profile
    # Mass assign edited profiles attributes and save (update)
    if @profile.update_attributes( profile_params )
      flash[:success] = "Profile Updated!"
      # Redirect user to their profiles page
      redirect_to user_path( id: params[:user_id] )
    else
      render action: :edit
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone_number, :contact_email, :description)
    end

    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end