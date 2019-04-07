class Api::StoresController < Api::ApiController
  def shop
    render json: Store.find(params[:id]).to_shop
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    render json: Shift.where(store_id: params[:store_id])
      .to_time_slots(params[:from], params[:to])
  end
end
