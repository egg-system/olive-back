import moment from 'moment'
moment.locale('ja')

import { renderCalendar } from './render/calendar'
import { renderShiftCheckboxes } from './render/shifts-checkboxes'
import { renderAssignableStaffSelect } from './render/assignable-staff-select'
import { renderReservationCalendar } from './render/reservation-calendar'
import { renderDownloadButton } from './render/download';
import { renderInputMenuOptions } from './render/reservation-input-menu-options';

// カレンダーの描画処理
renderCalendar()

// シフト用のチェックボックスの描画処理
renderShiftCheckboxes()

// 予約一覧のカレンダー表示
renderReservationCalendar()

// ダウンロードリンク
renderDownloadButton()

// メニュー・オプションの描画
renderInputMenuOptions()

// シフトの空いているスタッフのみのセレクトボックスの描画処理
// ※ メニュー・オプションの描画後に実行すること
renderAssignableStaffSelect()