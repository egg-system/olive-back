# time型を扱いやすくするための実装
ActiveModel::Type.register(:time_only, Tod::TimeOfDayType)
ActiveRecord::Type.register(:time_only, Tod::TimeOfDayType)
