class MedicalRecordsController < ApplicationController
  before_action :set_relations , only: :index

  def index
    @medical_record = MedicalRecord.find_or_initialize_by(
      customer_id: params[:id]
    )
  end

  def create
    # To Do medical_recordがある場合は更新処理(update)
    # 無い場合は登録処理（create）

    # ToDo ストロングパラメーターズ

    # indexにリダイレクト
  end

  private
  def set_relations
    @many_postures = ManyPosture.all
    @drinkings = Drinking.all
    @cigarettes = Cigarette.all
    @massages = Massage.all
    @exercises = Exercise.all
  end
end
