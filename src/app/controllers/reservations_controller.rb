class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :search, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.join_tables

    if params[:customer_name].present?
      @reservations = @staffs.where("concat(first_name, last_name) like ?", "%#{params[:customer_name]}%")
      @customer_name = params[:customer_name]
    end
    @stores = Store.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @pregnant_state = PregnantState.all
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @pregnant_state = PregnantState.all
  end

  def search
      redirect_to reservations_path({customer_name: params[:customer_name]})
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @stores = Store.all
    @pregnant_state = PregnantState.all
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
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
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
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
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:id, :customer_id, :reservation_date, :start_time, :end_time, :reservation_comment, :pregnant_state_id, :children_count, :is_first)
    end
end
