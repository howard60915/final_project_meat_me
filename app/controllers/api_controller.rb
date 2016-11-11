class ApiController < ActionController::Base

  before_action :authenticate_user_from_token!
  before_action :enabled_cors
  # after_action :add_after_action

  private

  def authenticate_user_from_token!

   if params[:auth_token].present?
    user = User.find_by_authentication_token(params[:auth_token])

     sign_in(user, store: false) if user

   end

  end

  def add_after_action
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Reuqested-With, Content-Type, Accept'
  end

  def enabled_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport, X-Remote, api_key, auth_token, *'
    headers['Access-Control-Request-Method'] = 'GET, POST, PUT, DELETE'
    headers['Access-Control-Request-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport,  X-Remote, api_key, *'
  end

end
