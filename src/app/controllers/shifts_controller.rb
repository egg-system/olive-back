class ShiftsController < ApplicationController
  before_action :set_relations, only: [:index, :new, :create]

  require 'csv'
  require 'time'
  require 'fileutils'

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
    @store = Store.find(@search_params[:store_id])
    @staff = Staff.find(@search_params[:staff_id])
  end

  def new
    @shift = Shift.new
  end

  def save
    uploaded_file = csv_params[:shift_csv]
    # validate only csv
    if uploaded_file.content_type != 'text/csv'
      flash[:alert] = "csvファイルをアップロードしてください。"
      return redirect_to action: :new
    end

    file_name = uploaded_file.original_filename
    save_path = Shift.save_csv_path(file_name)
    FileUtils.mv(uploaded_file.path, save_path)
    return redirect_to confirm_shifts_path(name: file_name)
  end

  def confirm
    @file_name = confirm_params[:name]
    return redirect_to action: :new if !File.exist?(Shift.save_csv_path(@file_name))

    @shifts = []
    csv_reader(@file_name).map { |row|
      @shifts.push(Shift.make_from_csv(row))
    }
    @shifts = @shifts.group_by { |i| i.date }
  end

  # POST /shifts
  # POST /shifts.json
  def create
    begin
      Shift.transaction do
        imports
      end
      redirect_to action: :index
    rescue Encoding::UndefinedConversionError => e
    rescue Encoding::InvalidByteSequenceError => e
      flash[:alert] = "文字コードがShift-JISのファイルをアップロードしてください。"
      return redirect_to action: :new
    end
  end

  def updates
    Shift.transaction do
      create_shifts
      delete_shifts if delete_shift_ids.present?
    end

    redirect_to action: :index
  end

  protected

  def set_relations
    @stores = viewable_stores
    @staffs = viewable_staffs
  end

  def csv_reader(file_name)
    CSV.read(Shift.save_csv_path(file_name), headers: true, encoding: "Shift_JIS:UTF-8")
  end

  def imports
    csv_reader('test').map { |row|
      Shift.import(row)
    }
  end

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

  def confirm_params
    params.permit(:name)
  end

  def updates_params
    params.permit(:store_id, :staff_id, new_shifts: {}, remain_shift_ids: {})
  end
end
