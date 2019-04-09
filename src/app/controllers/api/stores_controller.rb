class Api::StoresController < Api::ApiController
  def shop
    render json: Store.find(params[:id]).to_shop
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    must_skill_ids = Menu.where(id: params[:menu_ids]).select('skill_id').distinct
    staff_ids = Staff.has_must_skills(must_skill_ids).select('id')
  
    render json: Shift.where(store_id: params[:id])
      .where(staff_id: staff_ids)
      .where(date: (params[:from_date])..(params[:to_date]))
      .has_any_reservation
      .to_time_slot
  end
end
