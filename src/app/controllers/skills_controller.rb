class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :update, :destroy]

  # GET /skills
  # GET /skills.json
  def index
    @skills = Skill.all
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      redirect_to @skill, notice: I18n.t("successes.messages.create")
    else
      render :new
    end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
    if @skill.update(skill_params)
      redirect_to @skill, notice: I18n.t("successes.messages.update")
    else
      render :show
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    begin
      @skill.destroy!
      redirect_to skills_url, notice: I18n.t("successes.messages.destroy")
    rescue
      redirect_to skill_url(@skill.id), notice: 'すでに利用されているため、削除できません'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_skill
    @skill = Skill.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def skill_params
    params.require(:skill).permit(:id, :name)
  end
end
