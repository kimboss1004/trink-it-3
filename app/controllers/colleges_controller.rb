class CollegesController < ApplicationController


  def show
    @college = College.find(params[:id])
  end

  def index
    if logged_in? && current_user.college
    	redirect_to college_path(current_user.college)
    	return
    end
  end
  
end
