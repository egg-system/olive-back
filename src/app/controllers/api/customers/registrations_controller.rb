class Api::Customers::RegistrationsController < DeviseTokenAuth::RegistrationsController
  include TokenAuthenticable

  skip_before_action :authenticate_staff!
  skip_before_action :authenticate_api_customer!, only: :create
  after_action :send_registration_mail, only: :create

  def create
    return super if should_sign_up?

    new_customer = Customer.find_or_initialize_by({
      email: sign_up_params[:email],
      provider: sign_up_params[:provider],
    })
    new_customer.update!(sign_up_params)

    # superの返り値に合わせる
    render json: { status: 'success', data: new_customer }
  end

  private

  CUSTMER_PARAMETES = [
    :first_name,
    :last_name,
    :first_kana,
    :last_kana,
    :tel,
    :zip_code,
    :prefecture,
    :city,
    :first_visit_store_id,
    :last_visit_store_id,
    :can_receive_mail,
  ]

  def sign_up_params
    # email, password, 認証方式は更新不可
    params.permit(CUSTMER_PARAMETES.concat([
      :email,
      :password,
      :provider,
    ]))
  end

  def account_update_params
    params.permit(CUSTMER_PARAMETES)
  end

  def should_sign_up?
    sign_up_params[:provider] === 'email'
  end

  def send_registration_mail
    CustomerMailer.confirm_register(@resource).deliver_now if should_sign_up? && @resource.errors.blank?
  end
end
