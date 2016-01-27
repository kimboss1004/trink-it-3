class SessionsController < ApplicationController

  def new
    
  end

  def facebook_create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if current_user.college.nil?
      flash[:success] = "You have been registered. Please select the college you attend."
      redirect_to join_college_user_path(current_user)
      return
    else
      flash[:success] = "you have been signed in."
      redirect_to college_path(current_user.college)
      return
    end
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user && user.provider.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      if(user.college.nil?)
        flash[:success] = "You are signed in. Please select your college."
        redirect_to join_college_user_path(current_user)
        return
      else
        flash[:success] = "You are signed in succesfully."
        redirect_to college_path(current_college)
        return
      end
    else
      flash[:error] = "Incorrect email address or password. Or Login with Facebook"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been signed out succesfully"
    redirect_to root_path
  end
end