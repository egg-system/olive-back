class Customer < ApplicationRecord
    belongs_to :first_visit_store
    belongs_to :last_visit_store
    belongs_to :job_type, optional: true
    belongs_to :zoomancy, optional: true
    belongs_to :baby_age, optional: true
    belongs_to :size, optional: true
    belongs_to :visit_reason, optional: true
    belongs_to :nearest_station, optional: true
end
