class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_relation_models, only: [:new, :show, :update, :create]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all.join_tables

    @search_params = search_params
    @customers = @customers.like_name(@search_params[:name]) if @search_params[:name].present?
    @customers = @customers.where(tel: @search_params[:tel]) if @search_params[:tel].present?
    @customers = @customers.paginate(@search_params[:page], 20)
  end

  def search
    redirect_to customers_path(search_params)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.join_tables.find(params[:id])
    @reservations = @customer.reservations.order_reserved_at
  end

  # GET /customers/new
  def new
    # 画面入力の場合、非会員をデフォルト値にする
    @customer = Customer.new(provider: 'none')
  end

  # POST /customers
  # POST /customers.json
  def create
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
        @reservations = @customer.reservations.order_reserved_at
        format.html { render :show }
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

    def set_relation_models
      @occupations = Occupation.all
      @zoomancies = Zoomancy.all
      @baby_ages = BabyAge.all
      @sizes = Size.all
      @visit_reasons = VisitReason.all
      @nearest_stations = NearestStation.all
      @stores = Store.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(
        :first_name, :last_name, :first_kana, :last_kana, :tel, :pc_mail, :can_receive_mail,
        :first_visit_store_id, :last_visit_store_id, :comment, :zip_code, :address, :birthday,
        :phone_mail, :email, :provider, :password, :occupation_id, :zoomancy_id,
        :children_count, :baby_age_id, :size_id, :has_registration_card, :card_number
        )
    end

    def search_params
      params.permit(:name, :tel, :page)
    end
end
