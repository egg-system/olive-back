module LoginStoreModule
  extend ActiveSupport::Concern

  def find_for_authentication(tainted_conditions)
    login = tainted_conditions[:login]
    staff = find_first_by_auth_conditions(login: login)
    return nil if staff.nil?
    
    store_id = tainted_conditions[:login_store_id]
    stores = staff.stores.where(id: store_id)
    return nil if stores.empty?
    
    staff.login_store_id = store_id
    return staff
  end

  def serialize_into_session(staff)
    [staff.to_key, staff.authenticatable_salt, staff.login_store_id]
  end

  def serialize_from_session(key, salt, login_store_id = nil)
    staff = to_adapter.get(key)
    staff.login_store_id = login_store_id
    staff if staff && staff.authenticatable_salt == salt
  end

  def serialize_into_cookie(staff)
    [staff.to_key, staff.rememberable_value, Time.now.utc.to_f.to_s, staff.login_store_id]
  end

  def serialize_from_cookie(*args)
    id, token, generated_at, login_store_id = *args

    staff = to_adapter.get(id)
    staff.login_store_id = login_store_id
    staff if staff && staff.remember_me?(token, generated_at)
  end
end