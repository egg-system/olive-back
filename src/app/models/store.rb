class Store < ApplicationRecord
    enum store_type: { owned: 0, franchised: 1 }
end
