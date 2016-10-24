class SessionsController < ApplicationController

#TODO  INDEX
  def index
  end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path if auth_hash['uid'].nil?

    @user = Merchant.find_by(uid: auth_hash[:uid], provider: 'google')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = Merchant.build_from_google(auth_hash)
      render :creation_failure unless @user.save
    end

    redirect_to sessions_path
  end

  def destroy
  session.delete(:user_id)
  redirect_to root_path
  end

end
