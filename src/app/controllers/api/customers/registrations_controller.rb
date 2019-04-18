class Api::Customers::RegistrationsController < DeviseTokenAuth::RegistrationsController
  include Concerns::TokenAuthenticable

  skip_before_action :authenticate_staff!
  skip_before_action :authenticate_api_customer!, only: :create
  
  def create
    if should_sign_up?
      return super
    end

    new_customer = Customer.find_or_initialize_by({
      email: sign_up_params[:email],
      provider: sign_up_params[:provider],
    })
    new_customer.update_attributes!(sign_up_params)
      
    render json: new_customer
  end

  private

  CUSTMER_PARAMETES = [
    :first_name, 
    :last_name,
    :first_kana, 
    :last_kana,
    :email,
    :password,
    :tel,
    :first_visit_store_id,
    :last_visit_store_id,
    :provider,
  ]

  def sign_up_params
    params.permit(CUSTMER_PARAMETES)
  end

  def account_update_params
    params.permit(CUSTMER_PARAMETES)
  end
  
  def should_sign_up?
    sign_up_params[:provider] === 'email'
  end
end
