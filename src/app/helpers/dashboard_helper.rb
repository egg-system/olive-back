module DashboardHelper
  def store_staff_options(store_with_staffs)
    store_staff_hash = store_with_staffs.map do |store|
      {
        id: store.id,
        name: store.name,
        staffs: store.staffs.map do |staff|
          { id: staff.id, name: staff.name }
        end
      }
    end

    return store_staff_hash.to_json
  end
end
