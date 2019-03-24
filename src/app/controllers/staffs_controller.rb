class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.join_tables
    if params[:store_id].present?
      @staffs = @staffs.get_by_store params[:store_id]
      @store_id = params[:store_id]
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
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
    @staff.skill_staff.build
    @stores = Store.all
    @roles = Role.all
    @skills = Skill.all
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)
    @stores = Store.all
    @skills = Skill.all
    @roles = Role.all
    respond_to do |format|
      begin
        @staff.save!
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
        return  self.created(@staff.login, @staff.password)
      rescue => exception
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  def created(login, password)
    @login = login
    @password = password
      render template: "staffs/created"
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    if params[:is_delete]
      return self.destroy
    end

    respond_to do |format|
      begin
        @staff.update!(staff_params)
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
    id = @staff.id
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: "スタッフID:#{id}を削除しました" }
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
      params.require(:staff).permit(:first_name, :last_name, :first_kana, :last_kana, :store_id, :employment_type, :role_id, :login, :password, :skill_staff_attributes => [:skill_id])
    end

end
