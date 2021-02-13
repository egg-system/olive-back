class CsvShiftsController < ApplicationController
  require 'fileutils'

  # GET /csv_shifts
  def new
    @shift = Shift.new
  end

  # POST /csv_shifts/save
  def save
    uploaded_file = csv_params[:shift_csv]
    if uploaded_file.content_type != 'text/csv'
      flash[:alert] = "csvファイルをアップロードしてください。"
      return redirect_to action: :new
    end

    file_name = uploaded_file.original_filename
    save_path = Shift.save_csv_path(file_name)
    FileUtils.mv(uploaded_file.path, save_path)
    return redirect_to confirm_csv_shifts_path(file_name: file_name)
  end

  # GET /csv_shifts/confirm
  def confirm
    @file_name = confirm_params[:file_name]
    csv_shifts = Shift.make_from_csv(@file_name)
    return redirect_to action: :new if csv_shifts.empty?

    # rubocop:disable Style/SymbolProc
    @start_date = csv_shifts.min { |s| s.date }&.date
    @end_date = csv_shifts.max { |s| s.date }&.date

    # paramから検索
    store_id = confirm_params[:store_id].present? ? confirm_params[:store_id].to_i : csv_shifts.first&.store_id
    staff_id = confirm_params[:staff_id].present? ? confirm_params[:staff_id].to_i : csv_shifts.first&.staff_id
    searched = csv_shifts.select { |s| s.store_id == store_id && s.staff_id == staff_id }
    # 検索したものを日付でグループ化
    @shifts = searched.group_by(&:date)
    @store = Store.find(store_id)
    @staff = Staff.find(staff_id)
  end

  # POST /csv_shifts
  # POST /csv_shifts.json
  def create
    @file_name = confirm_params[:file_name]
    return redirect_to action: :new if @file_name.blank?

    begin
      Shift.transaction do
        Shift.import(@file_name)
      end
      redirect_to shifts_path
    rescue Encoding::UndefinedConversionError => e
    rescue Encoding::InvalidByteSequenceError => e
      flash[:alert] = "文字コードがShift-JISのファイルをアップロードしてください。"
      return redirect_to action: :new
    end
  end

  def csv_params
    params.require(:shift).permit(:shift_csv)
  end

  def confirm_params
    params.permit(:file_name, :store_id, :staff_id)
  end
end
