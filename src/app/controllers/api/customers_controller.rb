class Api::CustomersController < Api::ApiController
	protect_from_forgery with: :null_session
  def create
    request_vals = JSON.parse(request.body.read)
    customer = Customer.find_by(email: request_vals['email'], has_membership: false) 
    if (!customer) then
      customer = Customer.new
    end
    customer.email = request_vals['email']
    customer.has_membership = false
    customer.first_name = request_vals['first_name']
    customer.first_kana = request_vals['first_name_kana']
    customer.last_name = request_vals['last_name']
    customer.last_kana  = request_vals['last_name_kana']
    customer.tel = request_vals['phone_number']
    customer.can_receive_mail = request_vals['can_receive_mail']
    customer.first_visit_store_id = request_vals['store_id']
    customer.last_visit_store_id = request_vals['store_id']
    logger.debug(customer)
    if (!customer.save) then
      logger.debug(customer.errors.inspect)
      render status: 500, json: { "error": "Internal Server Error" }
    else
      render json: { "result": "ok" }
    end
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    render json: {}
  end
end
