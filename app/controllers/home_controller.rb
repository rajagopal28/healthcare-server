class HomeController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    if session[:doctor_id]
      @doctor = Doctor.find(session[:doctor_id])
    end
  end
end
