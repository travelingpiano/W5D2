class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new,:create]
  before_action :require_logged_in, only: [:destroy]
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email],params[:user][:password])
    if user.nil?
      render text: "user not found"
    else
      login!(user)
      redirect_to new_sessions_url
    end
  end

  def destroy
    logout!
    redirect_to sessions_url
  end
end
