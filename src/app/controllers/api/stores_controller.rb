class Api::StoresController < Api::ApiController
  def shop
    render json: Store.find(params[:id]).to_shop
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    render json: {}
  end
end
