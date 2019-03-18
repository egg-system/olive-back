class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.join_tables
    if params[:store_id].present?
      @staffs = @staffs.get_by_store params[:store_id]
    end
    @stores = Store.all
  end

  def search
    redirect_to staffs_path(store_id: params[:store_id])
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    @staff = Staff.join_tables.find(params[:id])
    @stores = Store.all
    @roles = Role.all
    @skills = Skill.all
    @staff_skills = StaffsSkill.where({staff_id: params[:id]}).includes(:staff)
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      begin
        @staff.update(staff_params)
        format.html { redirect_to @staff, notice: '更新しました。' }
        format.json { render :show, status: :ok, location: @staff }
      rescue => exception
        format.html { redirect_to @staff, notice: '更新に失敗しました。'  }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:first_name, :last_name, :first_kana, :last_kana, :store_id, :employee_type, :role_id, {:skill_ids => []})
    end

end
