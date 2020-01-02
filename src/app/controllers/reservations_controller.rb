class ReservationsController < ApplicationController
  include Concerns::ReservationSearchable

  before_action :set_reservation, only: [:show, :update, :destroy, :cancel_confirm]
  before_action :set_relation_models, only: [:new, :create, :show, :search, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @order = params[:order]

    @states = Reservation.states
    @state = params[:state] if params[:state].present?

    @stores = viewable_stores
    @store_id = params[:store_id]

    @staffs = viewable_staffs
    @staff_id = params[:staff_id]

    @customer_name = params[:customer_name]
    @customer_tel = params[:customer_tel]
    
    @from_date = Date.parse(params[:from_date]) if params.has_key?(:from_date)
    @to_date = Date.parse(params[:to_date]) if params.has_key?(:to_date)  

    # concernに検索ロジックを切り出し
    @reservations = search_reservations
  end

  def search
    redirect_to reservations_path({
      customer_name: params[:customer_name],
      customer_tel: params[:customer_tel],
      state: params[:state],
      staff_id: params[:staff_id],
      store_id: params[:store_id],
      from_date: parse_date_params('from_date'),
      to_date: parse_date_params('to_date'),
      order: params[:order]
    })
  end

  # GET /reservations/new
  def new
    return redirect_to customers_path, flash: { alert: '顧客が選択されていません。' } unless params.has_key?(:customer_id)

    @reservation = Customer.find(params[:customer_id]).reservations.new
    @reservation_details_count = params.has_key?(:count) ? params[:count].to_i : 1
    @reservation.reservation_details.build(Array.new(@reservation_details_count))
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.build_shifts

    @customer = Customer.find(@reservation.customer_id)
    if @customer.first_visit_store_id.nil? && @customer.first_visited_at.nil?
      @customer.first_visit_store_id = @reservation.store_id
      @customer.first_visited_at = @reservation.reservation_date
    end
    @customer.last_visit_store_id = @reservation.store_id
    @customer.last_visited_at = @reservation.reservation_date

    respond_to do |format|
      ActiveRecord::Base.transaction do
        @customer.save!
        result = @reservation.save # 'save!'だとエラーになる
        raise '予約登録に失敗しました' if !result
      end
        format.html { redirect_to @reservation, notice: '予約登録に成功しました。' }
        format.json { render :show, status: :created, location: @reservation }
      rescue => exception
        flash[:alert] = '入力された日時は予約できません。別の日時に変更してください。' unless @reservation.shifts.present?
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    @reservation.assign_attributes(reservation_params)
    @reservation.build_shifts if @reservation.shifts.empty? && @reservation.staff_id.present?
    @reservation.shifts.delete_all if @reservation.staff_id.nil?

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: '予約の更新に成功しました。' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        flash[:alert] = '予約の更新に失敗しました。'
        format.html { render :show }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    reservation = Reservation.find(params[:id])
    reservation.cancel

    unless params[:do_send_cancel_mail?].nil?
      ReservationMailer.cancel_reservation(reservation).deliver_now
    end

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: '予約をキャンセルいたしました。' }
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
      @stores = viewable_stores
      @staffs = viewable_staffs
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(
        :id,
        :customer_id,
        :store_id,
        :staff_id,
        :reservation_date,
        :start_time,
        :end_time,
        :reservation_comment,
        :children_count,
        :is_first,
        :is_confirmed,
        :created_by,
        :canceled_by,
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
