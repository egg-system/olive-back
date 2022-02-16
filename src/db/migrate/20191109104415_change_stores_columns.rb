class ChangeStoresColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :stores, :open_at, :time, comment: '開店時刻。予約可能な範囲に影響。開店時刻〜休憩開始時刻、休憩終了時刻〜閉店時刻で予約可能'
    change_column :stores, :close_at, :time, comment: '閉店時刻。予約可能な範囲に影響。開店時刻〜休憩開始時刻、休憩終了時刻〜閉店時刻で予約可能'
    change_column :stores, :break_from, :time, comment: '休憩開始時刻。予約可能な範囲に影響。開店時刻〜休憩開始時刻、休憩終了時刻〜閉店時刻で予約可能'
    change_column :stores, :break_to, :time, comment: '休憩終了時刻。予約可能な範囲に影響。開店時刻〜休憩開始時刻、休憩終了時刻〜閉店時刻で予約可能'

    Store.all.each { |store|
      store.update(
        open_at: store.open_at && "#{store.open_at.sec}:00",
        close_at: store.close_at && "#{store.close_at.sec}:00",
        break_from: store.break_from && "#{store.break_from.sec}:00",
        break_to: store.break_to && "#{store.break_to.sec}:00"
      )
    }
  end
end
