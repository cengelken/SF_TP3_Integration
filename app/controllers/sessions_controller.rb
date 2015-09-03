class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user
      log_in(user)
      redirect_to case_sets_path
    else
      flash.now[:danger] = 'Unable to contact Salesforce'
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
