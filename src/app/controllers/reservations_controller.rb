class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :set_relation_models, only: [:new, :create, :show, :search, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @stores = Store.all
    @reservations = Reservation.joins(:customer).order_reserved_at
  
    @customer_name = params[:customer_name]
    @reservations = @reservations.where_customer_name(@customer_name) if @customer_name.present?
  
    @from_date = Date.parse(params[:from_date]) if params.has_key?(:from_date)
    @reservations = @reservations.where('reservation_date >= ?', @from_date) if @from_date.present?

    @to_date = Date.parse(params[:to_date]) if params.has_key?(:to_date)
    @reservations = @reservations.where('reservation_date < ?', @to_date) if @to_date.present?
  end

  # GET /reservations/new
  def new
    return redirect_to customers_path, flash: { alert: '顧客が選択されていません。' } unless params.has_key?(:customer_id)

    @reservation = Customer.find(params[:customer_id]).reservations.new
    @resrvation_details_count = params.has_key?(:count) ? params[:count].to_i : 1
    @reservation.reservation_details.build(Array.new(@resrvation_details_count))
  end

  def search
    if params['from_date(1i)'].present? && params['from_date(1i)'].present? && params['from_date(1i)'].present?
      from_date = Date.new(
        params['from_date(1i)'].to_i,
        params['from_date(2i)'].to_i,
        params['from_date(3i)'].to_i
      )
    end

    if params['to_date(1i)'].present? && params['to_date(2i)'].present? && params['to_date(3i)'].present?
      to_date = Date.new(
        params['to_date(1i)'].to_i,
        params['to_date(2i)'].to_i,
        params['to_date(3i)'].to_i
      )
    end
    
    redirect_to reservations_path({
      customer_name: params[:customer_name],
      from_date: from_date,
      to_date: to_date,
    })
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.build_shifts

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: '予約登録に成功しました。' }
        format.json { render :show, status: :created, location: @reservation }
      else
        @resrvation_details_count = @reservation.reservation_details.length
        flash[:alert] = @reservation.staff.nil?  ? "入力日時の予約枠は埋まっております。日時を変更してください。" : '予約の登録に失敗しました。'

        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: '予約の更新に成功しました。' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    Reservation.find(params[:id]).cancel
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: '予約を削除いたしました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_relation_models
      @coupons = Coupon.all
      @options = Option.all
      @stores = Store.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(
        :id,
        :customer_id,
        :store_id,
        :reservation_date,
        :start_time,
        :end_time,
        :reservation_comment,
        :children_count,
        :is_first,
        coupon_ids: [],
        reservation_details_attributes: [
          :id,
          :menu_id,
          :mimitsubo_count,
          option_ids: [],
        ]
      )
    end
end
