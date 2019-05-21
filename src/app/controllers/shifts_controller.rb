class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  require 'csv'
  require 'time'

  # GET /shifts
  # GET /shifts.json
  def index
    @month = search_params[:search_month]
    @staff_id = search_params[:staff_id]
    @date_shifts = Shift.where(
      store_id: search_params[:store_id],
      staff_id: search_params[:staff_id]
    ).where_months(@month)
    .group_by { |shift| shift.date.strftime('%Y-%m-%d') }
  end

  def new
    @shift = Shift.new
  end

  # POST /shifts
  # POST /shifts.json
  def create
    csv_rows = CSV.read(
      csv_params[:shift_csv].path,
      headers: true, encoding:
      "Shift_JIS:UTF-8"
    )

    @shifts = csv_rows.map { |row|
      Shift.import(row)
    }

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

  def register
    staff = Staff.find(params[:target_staff_id])
    error_messages = []
    #バリデーション
    params[:shifts].each do |date, checks_by_time|
      checks_by_time.each do |time, check|
        if check != '1' then
          shift = Shift.shift_of_staff_at_datetime(staff, DateTime.parse(time))
          if shift != nil && shift.reservation != nil then
            error_messages.push(time + "のシフトは予約済みのため削除できません")
          end
        end
      end
    end
    if 0 < error_messages.count then
    #TODO エラーメッセージを出力する
    else
    #登録処理
      params[:shifts].each do |date, checks_by_time|
        checks_by_time.each do |time, check|
          Shift.reflect_check(staff, DateTime.parse(time), check == '1')
        end
      end
    end
    #abort params[:shifts].inspect
    redirect_to action: :index
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
