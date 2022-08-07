class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name])
  end

  private
  def respond_with(resource, _opts = {})
    if params[:referred_by_code]
      resource.set_referred_by(params[:referred_by_code])
    end
    resource.save!
    resource.persisted? ? register_success : register_failed
  end
  def register_success
    render json: {token: "#{request.headers["warden-jwt_auth.token"]}",user: resource,message: 'Signed up.' }
  end
  def register_failed
    render json: { message: "Signed up failure." }
  end
end