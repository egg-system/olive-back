class CustomerIntegrationsController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def show
    @search_params = search_params

    @customers = Customer.all

    @customers = @customers.where(id: @search_params[:customer_id])if @search_params[:customer_id].present?
    @customers = @customers.like_email(@search_params[:email])

    @customers = @customers.paginate(@search_params[:page], 20)

  end

  def update
    @search_params = search_params
    
  end

  def search_params
    params.permit(:email, :include_deleted, :customer_id,)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end