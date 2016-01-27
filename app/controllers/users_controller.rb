class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update, :get_join_college, :join_college]
  before_action :current_user_must_be_owner, only: [:edit, :update, :get_join_college, :join_college]
  before_action :must_be_logged_out, only: [:home]
  before_action :no_college_member_users, only: [:get_join_college, :join_college]

  def home
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome you are now a registered member!"
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def edit
  
  end

  def update
    @user = current_user
    if @user.update_attributes(update_user_params)
      if params[:profile_images]
        params[:profile_images].each { |image|
          @user.profile_images.create(profile_image: image)
        }
      end
      flash[:success] = "Your changes have been saved."
      redirect_to edit_college_user_path(current_college, @user)
    else
      render :edit
    end
  end

  def get_join_college
    @user = User.find(params[:id])
  end

  def join_college
    college = College.find(params[:user][:college_id])
    user = current_user
    if user.update_attribute('college_id', college.id)
      flash[:success] = "You are registered as a #{college.name} student!"
      redirect_to college_path(college)
    else
      flash[:error] = "There was an error."
      render :get_join_college
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password)
  end

  def update_user_params
    if params[:user][:password] == ""
      return params.require(:user).permit(:name, :email_address)
    else
      return params.require(:user).permit(:name, :email_address, :password, :profile_image)
    end
  end

  def current_user_must_be_owner
    if User.find(params[:id]) != current_user
      redirect_to (current_college ? college_path(current_college): root_path) 
    end
  end

  def no_college_member_users
    redirect_to college_path(current_college) unless current_user.college.nil?
  end
end