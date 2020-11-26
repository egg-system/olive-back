import { renderCalendar } from './render/calendar'
import { renderShiftCheckboxes } from './render/shifts-checkboxes'
import { renderAssignableStaffSelect } from './render/assignable-staff-select'

// カレンダーの描画処理
renderCalendar()

// シフト用のチェックボックスの描画処理
renderShiftCheckboxes()

// シフトの空いているスタッフのみのセレクトボックスの描画処理
renderAssignableStaffSelect()
