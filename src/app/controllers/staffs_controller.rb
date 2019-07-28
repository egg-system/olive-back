# frozen_string_literal: true

class StaffsController < ApplicationController
  before_action :set_staff, only: %i[show update destroy]
  before_action :set_relation_models, only: %i[new create show update]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all
    if params[:store_id].present?
      @staffs = @staffs.where_store_id(params[:store_id])
      @store_id = params[:store_id]
    end

    if params[:staff_name].present?
      @staffs = @staffs.where('concat(last_name, first_name) like ?', "%#{params[:staff_name]}%")
      @staff_name = params[:staff_name]
    end

    @stores = Store.all
    @staff_skills_list = ActiveRecord::Base.connection.select_all('select skill_staffs.staff_id, group_concat(skills.name) as skills_list FROM `skill_staffs` INNER JOIN `skills` ON `skills`.`id` = `skill_staffs`.`skill_id` GROUP BY `skill_staffs`.`staff_id`').to_hash
  end

  def search
    redirect_to staffs_path(store_id: params[:store_id], staff_name: params[:staff_name])
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    @staff = Staff.join_tables.find(params[:id])
    @staff_skills = SkillStaff.where(staff_id: params[:id])
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
    @staff.skill_staffs.build
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)
    respond_to do |format|
      @staff.save!
      format.html { redirect_to @staff, notice: 'スタッフが登録されました。' }
      format.json { render :show, status: :created, location: @staff }
    rescue StandardError => e
      flash[:alert] = 'スタッフを登録できませんでした。'
      format.html { render :new }
      format.json { render json: @staff.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    return destroy if params[:is_delete]

    respond_to do |format|
      @staff.update!(staff_params)
      format.html { redirect_to @staff, notice: '更新しました。' }
      format.json { render :show, status: :ok, location: @staff }
    rescue StandardError => e
      flash[:alert] = '更新に失敗しました。'
      format.html { render :show }
      format.json { render json: @staff.errors, status: :unprocessable_entity }
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

  protected

  def set_relation_models
    @stores = Store.all
    @roles = Role.all
    @skills = Skill.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_staff
    @staff = Staff.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def staff_params
    staff_params = params
                   .require(:staff)
                   .permit(
                     :first_name,
                     :last_name,
                     :first_kana,
                     :last_kana,
                     :employment_type,
                     :role_id,
                     :login,
                     :password,
                     { skill_ids: [] },
                     store_ids: []
                   )
    staff_params.delete(:password) if staff_params[:password].empty?
    staff_params
  end
end
