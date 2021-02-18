class CsvShiftsController < ApplicationController
  require 'fileutils'
  require 'csv'

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

    begin
      csv_shifts = make_from_csv(@file_name)
    rescue Encoding::UndefinedConversionError => e
      flash[:alert] = "文字コードがShift-JISのファイルをアップロードしてください。"
      return redirect_to action: :new
    rescue Encoding::InvalidByteSequenceError => e
      flash[:alert] = "文字コードがShift-JISのファイルをアップロードしてください。"
      return redirect_to action: :new
    rescue Errno::ENOENT => e
      flash[:alert] = "ファイルが開けません。再度アップロードしてください。"
      return redirect_to action: :new
    end

    if csv_shifts.empty?
      flash[:alert] = "CSVに有効なデータがありません。ファイルの内容をご確認ください。"
      return redirect_to action: :new
    end

    @start_date, @end_date = get_csv_shifts_min_max(csv_shifts)
    @store, @staff = extract_store_staff_from_params(csv_shifts)

    searched = csv_shifts.select { |shift|
      shift.store_id == @store.id && shift.staff_id == @staff.id
    }

    store_ids = csv_shifts.map { |shift| shift.store_id }.uniq
    @stores = Store.where(id: store_ids)
    staff_ids = csv_shifts.map { |shift| shift.staff_id }.uniq
    @staffs = Staff.where(id: staff_ids)

    # 検索したものを日付でグループ化
    @shifts = searched.group_by { |shift| shift.date.strftime('%Y-%m-%d') }
  end

  # POST /csv_shifts
  # POST /csv_shifts.json
  def create
    @file_name = confirm_params[:file_name]
    return redirect_to action: :new if @file_name.blank?

    begin
      Shift.transaction do
        import(@file_name)
      end
      redirect_to shifts_path
    rescue Encoding::UndefinedConversionError => e
      flash[:alert] = "文字コードがShift-JISのファイルをアップロードしてください。"
      return redirect_to action: :new
    rescue Encoding::InvalidByteSequenceError => e
      flash[:alert] = "文字コードがShift-JISのファイルをアップロードしてください。"
      return redirect_to action: :new
    rescue Errno::ENOENT => e
      flash[:alert] = "ファイルが開けません。再度アップロードしてください。"
      return redirect_to action: :new
    end
  end

  def csv_params
    params.require(:shift).permit(:shift_csv)
  end

  def confirm_params
    params.permit(:file_name, :store_id, :staff_id)
  end

  def get_csv_shifts_min_max(csv_shifts)
    min_date = csv_shifts.min{ |shift| shift.date }&.date
    max_date = csv_shifts.max { |shift| shift.date }&.date
    return min_date.strftime('%Y-%m-%d'), max_date.strftime('%Y-%m-%d')
  end

  private

  def csv_reader(file_path)
    CSV.read(file_path, headers: true, encoding: "Shift_JIS:UTF-8")
  end

  def import(file_name)
    csv_reader(Shift.save_csv_path(file_name)).flat_map { |row|
      Shift.parse(row).map{ |shift_data|
        Shift.where(shift_data).first_or_create
      } 
    }
  end

  def make_from_csv(file_name)
    csv_reader(Shift.save_csv_path(file_name)).flat_map { |row|
      Shift.parse(row).map{ |shift_data| Shift.new(shift_data) }
    }
  end

  def extract_store_staff_from_params(csv_shifts)
    # paramから検索
    # rubocop:disable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment
    store_id = if confirm_params[:store_id].present?
      confirm_params[:store_id].to_i
    else
      csv_shifts.first&.store_id
    end

    staff_id = if confirm_params[:staff_id].present?
      confirm_params[:staff_id].to_i
    else
      csv_shifts.first&.staff_id
    end
    # rubocop:enable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment

    return Store.find(store_id), Staff.find(staff_id)
  end
end
