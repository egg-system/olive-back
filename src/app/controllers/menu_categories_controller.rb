class MenuCategoriesController < ApplicationController
  before_action :set_menu_category, only: [:show, :update, :destroy]

  # GET /menu_categories
  # GET /menu_categories.json
  def index
    @menu_categories = MenuCategory.join_tables
  end

  # GET /menu_categories/1
  # GET /menu_categories/1.json
  def show
    @departments = Department.all
  end

  # GET /menu_categories/new
  def new
    @menu_category = MenuCategory.new
    @departments = Department.all
  end

  # POST /menu_categories
  # POST /menu_categories.json
  def create
    @menu_category = MenuCategory.new(menu_category_params)

    respond_to do |format|
      if @menu_category.save
        format.html { redirect_to @menu_category, notice: 'Menu category was successfully created.' }
        format.json { render :show, status: :created, location: @menu_category }
      else
        format.html { render :new }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_categories/1
  # PATCH/PUT /menu_categories/1.json
  def update
    respond_to do |format|
      if @menu_category.update(menu_category_params)
        format.html { redirect_to @menu_category, notice: 'Menu category was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu_category }
      else
        format.html { render :edit }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_categories/1
  # DELETE /menu_categories/1.json
  def destroy
    begin
      @menu_category.destroy!
      respond_to do |format|
        format.html { redirect_to menu_category_url, notice: 'Skill was successfully destroyed.' }
        format.json { head :no_content }
      end
    rescue StandardError
      respond_to do |format|
        format.html { redirect_to menu_category_url(@menu_category.id), notice: 'すでに利用されているため、削除できません' }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_menu_category
    @menu_category = MenuCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_category_params
    params.require(:menu_category).permit(:name, :department_id)
  end
end
