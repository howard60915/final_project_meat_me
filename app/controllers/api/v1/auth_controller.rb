class Api::V1::AuthController < ApiController

  before_action :authenticate_user!, :only => :logout

  def login
    success = false

    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
      success = user && user.valid_password?(params[:password])
      user.generate_authentication_token
      user.save!
    end

    if success
      render :json => { :status => 200,
                        :message => "Login OK",
                        :user_id => user.id,
                        :auth_token => user.authentication_token
                       }
    else
      render :json => { :message => "Login Failed" }, :status => 401
    end
  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render :json => { :message => "Logout OK" }
  end

  
end