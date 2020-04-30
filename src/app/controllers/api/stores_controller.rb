class Api::StoresController < Api::ApiController
  def shop
    render json: Store.find(params[:id]).to_shop
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    staff_ids = Staff
      .can_treats(params[:menu_ids], params[:option_ids])
      .select('id')

    render json: Shift.where(store_id: params[:id])
      .where(staff_id: staff_ids)
      .where(date: (params[:from_date])..(params[:to_date]))
      .where_not_reserved
      .to_time_slots
  end
end
