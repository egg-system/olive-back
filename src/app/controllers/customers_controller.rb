class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_relation_models, only: [:new, :show, :update, :create]

  # GET /customers
  # GET /customers.json
  def index
    @customers = current_staff.readable_customers.join_tables

    @search_params = search_params

    # like検索ではパラメータチェックは不要
    @customers = @customers.like_name(@search_params[:name])
    @customers = @customers.like_kana_name(@search_params[:kana_name])
    @customers = @customers.like_tel(@search_params[:tel])
    @customers = @customers.like_email(@search_params[:email])

    # 基本的に、未使用フラグの立った顧客は検索に表示しない
    ## include_deletedがtrueの場合のみ、未使用フラグの立った顧客を検索結果に含める
    @customers = @customers.where_deleted(false) unless @search_params[:include_deleted] === '1'

    @customers = @customers.paginate(@search_params[:page], 20)
  end

  def search
    redirect_to customers_path(search_params)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = current_staff.readable_customers.join_tables.find(params[:id])
    @reservations = @customer.reservations.order_reserved_at
    @observations = @customer.observations.order(visit_datetime: :desc)
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

        if @customer.visit_stores.blank?
          visit_store = @customer.visit_stores.build(store_id: view_context.current_store.id)
          visit_store.save
        end

        # rubocopに従うとネストが深くなりすぎるため、無効化
        # rubocop:disable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment
        result = if @customer.square_customer_exists?
          '新規作成、Square連携に成功しました。'
        else
          'square連携に失敗しました。入力内容が誤っている可能性があります。お手数ですが、修正後にもう一度、更新してください。'
        end
        # rubocop:enable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment

        format.html { redirect_to @customer, notice: result }
        format.json { render :show, status: :created, location: @customer }
      rescue StandardError => exception
        # square連携のエラーをログに表示するため
        logger.debug(exception)
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

        # rubocopに従うとネストが深くなりすぎるため、無効化
        # rubocop:disable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment
        result = if @customer.synced_square_customer?
          '新規作成、Square連携に成功しました。'
        else
          'square連携に失敗しました。入力内容が誤っている可能性があります。お手数ですが、修正後にもう一度、更新してください。'
        end
        # rubocop:enable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment

        format.html { redirect_to @customer, notice: result }
        format.json { render :show, status: :ok, location: @customer }
      rescue StandardError => exception
        # square連携のエラーをログに表示するため
        logger.debug(exception)
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
    @customer = current_staff.readable_customers.find(params[:id])
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
      :fmid, :first_name, :last_name, :first_kana, :last_kana,
      :tel, :fixed_line_tel, :display_email, :can_receive_mail,
      :first_visit_store_id, :first_visited_at, :last_visit_store_id, :comment,
      :zip_code, :address, :birthday, :card_number, :has_registration_card,
      :introducer, :visit_reason_id, :nearest_station_id, :searched_by, :children_count, :baby_age_id,
      :occupation_id, :zoomancy_id, :size_id, :provider, :password, :is_deleted, :fm_total_amount, :memo,
      visit_store_ids: []
    )
  end

  def search_params
    params.permit(:name, :kana_name, :tel, :email, :include_deleted, :page)
  end
end
