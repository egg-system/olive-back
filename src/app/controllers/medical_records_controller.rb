class MedicalRecordsController < ApplicationController
  before_action :set_relations , only: :index

  def index
    # データがあれば返して、無ければ新規作成して保存はしない
    @medical_record = MedicalRecord.find_or_initialize_by(
      customer_id: params[:id]
    )
  end

  def create
    @medical_record = MedicalRecord.find_or_initialize_by(
      customer_id: params[:id]
    )
    @medical_record.update_attributes(medical_record_params)
    redirect_to medical_records_path, notice: '更新しました。'
  end

  private

  def set_relations
    @pregnancies = Pregnancy.all
    @many_postures = ManyPosture.all
    @drinkings = Drinking.all
    @cigarettes = Cigarette.all
    @massages = Massage.all
    @exercises = Exercise.all
    @hope_menus = HopeMenu.all
    @treat_goals = TreatGoal.all
    @current_hospitals = CurrentHospital.all
  end

  def medical_record_params
    params.require(:medical_record).permit(
      :id,
      :pain,
      :current_sickness,
      :past_sickness,
      :right_hand,
      :pregnancy_id,
      :many_posture_id,
      :drinking_id,
      :cigarette_id,
      :massage_id,
      :exercise_id,
      hope_menu_ids: [],
      treat_goal_ids: [],
      current_hospital_ids: [],
    )
  end
end

