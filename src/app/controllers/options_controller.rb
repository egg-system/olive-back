# frozen_string_literal: true

class OptionsController < ApplicationController
  before_action :set_option, only: %i[show update destroy]
  before_action :set_master, only: %i[show new update]

  # GET /options
  # GET /options.json
  def index
    @options = Option.all
  end

  # GET /options/1
  # GET /options/1.json
  def show; end

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
        format.html { redirect_to @option, notice: I18n.t('successes.messages.create') }
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
        format.html { redirect_to @option, notice: I18n.t('successes.messages.update') }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy
    @option.reservation_details
    if @option.reservations.count > 0
      redirect_to option_url(@option.id), notice: 'すでに利用されているため、削除できません'
    else
      @option.destroy
      respond_to do |format|
        format.html { redirect_to options_url, notice: I18n.t('successes.messages.destroy') }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_option
    @option = Option.find(params[:id])
  end

  def set_master
    @departments = Department.all
    @skills = Skill.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def option_params
    params.require(:option).permit(:name, :description, :fee, :start_at, :end_at, :department_id, :skill_id)
  end
end
