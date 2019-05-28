class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  require 'csv'
  require 'time'

  # GET /shifts
  # GET /shifts.json
  def index
    @search_params = search_params
    @date_shifts = Shift
      .where(
        store_id: @search_params[:store_id],
        staff_id: @search_params[:staff_id]
      ).where_months(@search_params[:month])
      .group_by { |shift| shift.date.strftime('%Y-%m-%d') }

      @start_date, @end_date = Shift.get_month_range(@search_params[:month])
  end

  def new
    @shift = Shift.new
  end

  # POST /shifts
  # POST /shifts.json
  def create
    if !params[:shift] then
      flash[:alert] = "ファイルをアップロードしてください。"
      return redirect_to action: :new
    end
    Shift.transaction do
      @shifts = CSV.read(
        csv_params[:shift_csv].path,
        headers: true,
        encoding: "Shift_JIS:UTF-8"
      ).map { |row|
        Shift.import(row)
      }
      redirect_to action: :index
    end
    rescue Encoding::UndefinedConversionError => e
      flash[:alert] = "文字コードがShift-JISのファイルをアップロードしてください。"
      return redirect_to action: :new
  end

  def updates
    Shift.transaction do
      create_shifts
      delete_shifts if delete_shift_ids.present?
    end

    redirect_to action: :index
  end

  protected
  def create_shifts
    updates_params[:new_shifts]
      .select { |shift_at, checked| checked === '1' }
      .keys
      .each { |shift_at|
        Shift.create!(
          store_id: updates_params[:store_id],
          staff_id: updates_params[:staff_id],
          date: shift_at.to_date,
          start_at: shift_at.to_time,
          end_at: shift_at.to_time + Shift.get_shift_increment
        )
      }
  end

  def delete_shifts
    Shift.where(
      id: delete_shift_ids,
      store_id: updates_params[:store_id],
      staff_id: updates_params[:staff_id]
    ).delete_all
  end

  def delete_shift_ids
    return nil unless updates_params.has_key? :remain_shift_ids
    return updates_params[:remain_shift_ids].select { |id, checked| checked === '0' }.keys
  end

  private
  def search_params
    search_month = Date.today.beginning_of_month
    if params.has_key?("month(1i)") && params.has_key?("month(2i)")
      search_month = Date.new(params["month(1i)"].to_i, params["month(2i)"].to_i)
    end

    return {
      staff_id: params[:staff_id] || current_staff.id,
      store_id: params[:store_id] || current_staff.stores.first.id,
      month: search_month
    }
  end

  def csv_params
    params.require(:shift).permit(:shift_csv)
  end

  def updates_params
    params.permit(:store_id, :staff_id, new_shifts: {}, remain_shift_ids: {})
  end
end
