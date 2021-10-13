class CustomerIntegrationsController < ApplicationController
  before_action :forbidden_unless_admin
  before_action :set_customer

  def show
    assign_show_values
  end

  def integrate
    @customer.integrate!(params[:integration_customer_id])
    redirect_to customers_path, notice: '顧客統合が完了しました。'
  rescue => e
    logger.debug(e)

    @exception = e

    assign_show_values
    render :show
  end

  private

  def assign_show_values
    @search_params = search_params

    @customers = Customer.enabled.where.not(id: @customer.id)

    @customers = @customers.where(id: @search_params[:customer_id]) if @search_params[:customer_id].present?
    @customers = @customers.like_email(@search_params[:email])
    @customers = @customers.where_deleted(false) unless @search_params[:include_deleted] === '1'

    @customers = @customers.paginate(@search_params[:page], 20)
  end

  def search_params
    params.permit(:id, :customer_id, :email, :include_deleted, :page)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
