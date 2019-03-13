class Api::StoresController < Api::ApiController
  def show
    render json: Store.find(params[:id]).to_shop
  end
end
