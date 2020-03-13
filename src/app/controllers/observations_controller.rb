class ObservationsController < ApplicationController
  before_action :set_observation, only: [:show, :update, :destroy]
  before_action :set_relation_models, only: [:new, :show, :update, :create]

  # GET /observations/new
  def new
    return redirect_to customers_path, flash: { alert: '顧客が選択されていません。' } unless params.has_key?(:customer_id)

    @observation = Customer.find(params[:customer_id]).observations.new
  end

  # POST /observations
  # POST /observations.json
  def create
    @observation = Observation.new(observation_params)
    @observation.option_ids = option_ids

    respond_to do |format|
      if @observation.save
        format.html { redirect_to @observation, notice: '新規作成しました。' }
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1
  # PATCH/PUT /observations/1.json
  def update
    @observation.assign_attributes(observation_params)
    @observation.option_ids = option_ids

    respond_to do |format|
      if @observation.save
        format.html { redirect_to @observation, notice: '更新しました。' }
        format.json { render :show, status: :ok, location: @observation }
      else
        format.html { render :show }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @observation.destroy
    respond_to do |format|
      format.html { redirect_to customer_path(@observation.customer_id), notice: '削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    def set_observation
      @observation = Observation.find(params[:id])
    end

    def set_relation_models
      @stores = Store.all
      @staffs = Staff.all
      @menus = Menu.all
      @options = Option.all
    end

    def option_ids
      params[:observation][:option_ids].reject(&:blank?).join(',') if params[:observation][:option_ids].present?
    end

    def observation_params
      params.require(:observation).permit(
        :customer_id, :store_id, :visit_datetime, :staff_id, :menu_id, :merchandise, :observation_history, :coupon_count, :op_coupon_count
      )
    end
end
