class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.where(
      store_id: search_params[:store_id], 
      staff_id: search_params[:staff_id]
    ).to_month_slots(search_params[:search_month])
    .map { |shift| shift.first }

    # 月初に変換する
    @month_date = "#{search_params[:search_month]}-01".to_date
  end

  def new
    @shift = Shift.new
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shifts = Shift.imports(csv_params[:shift_csv])
    redirect_to action: :index
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def search_params
    result_params = {
      staff_id: params[:staff_id].nil? ? current_staff.id : params[:staff_id],
      store_id: params[:store_id].nil? ? current_staff.store_id : params[:store_id]
    }

    if params[:search_month].present?
      year = params[:search_month]['by(1i)']
      month = params[:search_month]['by(2i)']
      result_params[:search_month] = "#{year}-#{month}"
    else
      result_params[:search_month] = Time.current.strftime('%Y-%m')
    end

    return result_params
  end

  def csv_params
    params.require(:shift).permit(:shift_csv)
  end
end
