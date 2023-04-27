class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :update, :destroy]
  before_action :set_master, only: [:show, :new, :update, :create]
  before_action :set_before_index, only: [:create, :update, :destroy]
  after_action :rebuild_indexes, only: [:create, :update, :destroy]

  # GET /options
  # GET /options.json
  def index
    @options = Option.all
  end

  # GET /options/1
  # GET /options/1.json
  def show
  end

  # GET /options/new
  def new
    @option = Option.new
  end

  # POST /options
  # POST /options.json
  def create
    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        format.html { redirect_to @option, notice: I18n.t("successes.messages.create") }
        format.json { render :show, status: :created, location: @option }
      else
        format.html { render :new }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to @option, notice: I18n.t("successes.messages.update") }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :show }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy
    @option.reservation_details
    if 0 < @option.reservations.count then
      redirect_to option_url(@option.id), notice: 'すでに利用されているため、削除できません'
    else
      @option.destroy
      respond_to do |format|
        format.html { redirect_to options_url, notice: I18n.t("successes.messages.destroy") }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_before_index
    @before_index = @option&.index
  end

  def rebuild_indexes
    # エラーがあった場合は処理を実行しない
    return if @option.errors.any?

    # 新規レコードかどうか
    id = params[:id].nil? ? @option.id : params[:id]

    # 削除済みかどうか
    after_index = @option.destroyed? ? nil : @option.index
    Option.rebuild_indexes(id, @before_index, after_index)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_option
    @option = Option.find(params[:id])
  end

  def set_master
    @departments = Department.all
    @skills = Skill.all
    @menuCategories = MenuCategory.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def option_params
    params.require(:option).permit(
      :name,
      :description,
      :fee,
      :index,
      :start_at,
      :end_at,
      :department_id,
      :skill_id,
      menu_category_ids: []
    )
  end
end
