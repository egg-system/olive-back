class Api::StoresController < Api::ApiController
  def shop
    render json: Store.find(params[:id]).to_shop
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    staff_ids = Staff.can_treat_menus(params[:menu_ids]).select('id')
    render json: Shift.where(store_id: params[:id])
      .where(staff_id: staff_ids)
      .where(date: (params[:from_date])..(params[:to_date]))
      .has_any_reservation
      .to_time_slots
  end
end
