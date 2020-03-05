class ObservationsController < ApplicationController
  # before_action :set_observation, only: [:show, :edit, :update, :destroy]
  # before_action :set_relation_models, only: [:new, :show, :update, :create]

  # GET /observations
  # GET /observations.json
  def index
    @search_params = search_params
    
    @observations = Observation.all.paginate(@search_params[:page], 20)
  end

  private
    def search_params
      params.permit(:page)
    end
  #   def set_observation
  #     @observation = Observation.find(params[:id])
  #   end
end
