class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])
    @menu_categories = MenuCategory.all
    @skills = Skill.all
  end

  # GET /menus/new
  def new
    @menu = Menu.new
    @menu_categories = MenuCategory.all
    @skills = Skill.all
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: I18n.t("successes.messages.create") }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: I18n.t("successes.messages.update") }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    begin
      @menu.destroy!
      respond_to do |format|
        format.html { redirect_to menus_url, notice: I18n.t("successes.messages.destroy") }
        format.json { head :no_content }
      end
    rescue => exception
      respond_to do |format|
        format.html { redirect_to menu_url(@menu.id), notice: 'すでに利用されているため、削除できません' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_menu
    @menu = Menu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
    params.require(:menu).permit(:id, :name, :description, :fee, :service_minutes, :start_at, :end_at, :menu_category_id, :skill_id, :memo)
  end
end
