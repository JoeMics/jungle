class SessionsController < ApplicationController
  def new
  end

  def create
    # Make sure user exists & correct password
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # save user id as cookie in browser
      session[:user_id] = user.id
      redirect_to [:root]
    else 
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:login]
  end
end
