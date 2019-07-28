# frozen_string_literal: true

class CouponHistoriesController < ApplicationController
  before_action :set_coupon_history, only: %i[show update destroy]

  # GET /coupon_histories
  # GET /coupon_histories.json
  def index
    @coupon_histories = CouponHistory.join_tables
  end

  # GET /coupon_histories/1
  # GET /coupon_histories/1.json
  def show
    @coupons = Coupon.all
  end

  # GET /coupon_histories/new
  def new
    @coupon_history = CouponHistory.new
    @coupons = Coupon.all
  end

  # POST /coupon_histories
  # POST /coupon_histories.json
  def create
    @coupon_history = CouponHistory.new(coupon_history_params)

    respond_to do |format|
      if @coupon_history.save
        format.html { redirect_to @coupon_history, notice: 'Coupon history was successfully created.' }
        format.json { render :show, status: :created, location: @coupon_history }
      else
        format.html { render :new }
        format.json { render json: @coupon_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupon_histories/1
  # PATCH/PUT /coupon_histories/1.json
  def update
    respond_to do |format|
      if @coupon_history.update(coupon_history_params)
        format.html { redirect_to @coupon_history, notice: 'Coupon history was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon_history }
      else
        format.html { redirect_to coupon_history_url(@coupon_history.id), notice: '削除に失敗しました。' }
        format.json { render json: @coupon_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_histories/1
  # DELETE /coupon_histories/1.json
  def destroy
    @coupon_history.destroy
    respond_to do |format|
      format.html { redirect_to coupon_histories_url, notice: 'Coupon history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_coupon_history
    @coupon_history = CouponHistory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def coupon_history_params
    params.require(:coupon_history).permit(:customer_id, :coupon_id, :used_at)
  end
end
