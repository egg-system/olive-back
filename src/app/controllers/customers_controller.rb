class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all.join_tables
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.join_tables.find(params[:id])
    @customer.age = (Date.today.strftime('%Y%m%d').to_i - @customer.birthday.strftime('%Y%m%d').to_i) / 10000
    @stores = Store.all
    @reservations = Reservation.where({customer_id: params[:id]}).join_staff
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @stores = Store.all
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @stores = Store.all
    @customer = Customer.new(customer_params)

    respond_to do |format|
      begin
        @customer.save!
        format.html { redirect_to @customer, notice: '新規作成しました。' }
        format.json { render :show, status: :created, location: @customer }
      rescue => exception
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      begin
        @customer.update!(customer_params)
        format.html { redirect_to @customer, notice: '更新しました。' }
        format.json { render :show, status: :ok, location: @customer }
      rescue => exception
        format.html { redirect_to :show, location: @customer }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to @customer, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :first_kana, :last_kana, :tel, :pc_mail, :can_receive_mail, :first_visit_store_id, :last_visit_store_id, :comment, :zip_code, :address, :birthday, :phone_mail, :email, :password)
    end
end
