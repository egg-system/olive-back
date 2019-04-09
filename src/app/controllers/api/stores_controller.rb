class Api::StoresController < Api::ApiController
  def shop
    render json: Store.find(params[:id]).to_shop
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    mustSkillIds = Menu.where(id: params[:menu_ids]).get_must_skill_ids
    staffIds = Staff.has_must_skills(mustSkillIds).select('id')
    
    render json: Shift.where(store_id: params[:id])
      .where(staff_id: staffIds)
      .to_time_slots(params[:from_date], params[:to_date])
      .map { |shifts| Shift.to_date_slot(shifts) }
  end
end
