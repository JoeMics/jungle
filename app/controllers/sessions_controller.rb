class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    # Make sure user exists & correct password
    if user && user.authenticate(params[:password])
      # save user id as cookie in browser
      session[:user_id] = user.id
      puts 'LOGGED IN!'
      redirect_to [:root]
    else 
      puts 'FAILED LOGIN'
      redirect_to [:login]
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:login]
  end
end
