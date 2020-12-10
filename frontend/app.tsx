import { renderCalendar } from './render/calendar'
import { renderShiftCheckboxes } from './render/shifts-checkboxes'
import { renderAssignableStaffSelect } from './render/assignable-staff-select'
import { renderReservationCalendar } from './render/reservation-calendar'

// カレンダーの描画処理
renderCalendar()

// シフト用のチェックボックスの描画処理
renderShiftCheckboxes()

// シフトの空いているスタッフのみのセレクトボックスの描画処理
renderAssignableStaffSelect()

// 予約一覧のカレンダー表示
renderReservationCalendar()
