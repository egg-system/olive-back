import React from 'react'
import ReactDOM from 'react-dom'
import moment from 'moment'
import CalenderInput from '../class/CalendarInput'

const renderDateInput = (elementId: string) => {
  const dateValueElement: HTMLInputElement
    = document.getElementById(`${elementId}_value`) as HTMLInputElement
  
  // 関係のないページでは描画処理を実行しない
  if (!dateValueElement) {
    return
  }

  const clearable = dateValueElement.getAttribute('data-clearable')
  const isValid = Boolean(dateValueElement.value)
  if (!isValid && clearable !== 'true') {
    dateValueElement.value = moment().format('YYYY-MM-DD')
  }

  ReactDOM.render(
    <CalenderInput dateValueElement={ dateValueElement } isValid={ isValid } />,
    document.getElementById(elementId)
  )
}

export const renderCalendar = () => {
  renderDateInput('react_reservation_date')
  renderDateInput('react_first_visited_at')
  renderDateInput('react_visit_date')
  renderDateInput('react_birthday')
}
