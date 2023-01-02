import React from 'react'
import ReactDOM from 'react-dom'
import moment from 'moment'
import CalendarInput from '../class/CalendarInput'
import CalendarSearchInput from '../class/CalendarSearchInput'

const renderDateInput = (elementId: string) => {
  const valueElementId = `${elementId}_value`
  const dateValueElement = document.getElementById(valueElementId) as HTMLInputElement
  
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
    <CalendarInput dateValueElement={ dateValueElement } isValid={ isValid } />,
    document.getElementById(elementId)
  )
}

const renderDateSearchInput = () => {
  const startDateElementId = 'react_reservation_search_start_date'
  const startDateElement = document.getElementById(startDateElementId) as HTMLInputElement

  const endDateElementId = 'react_reservation_search_end_date'
  const endDateElement = document.getElementById(endDateElementId) as HTMLInputElement

  if (!startDateElement || !endDateElement) {
    return
  }

  ReactDOM.render(
    <CalendarSearchInput
      startDateElement={ startDateElement }
      endDateElement={ endDateElement }
    />,
    document.getElementById('react_reservation_date_search')
  )
}

export const renderCalendar = () => {
  renderDateInput('react_reservation_date')
  renderDateInput('react_first_visited_at')
  renderDateInput('react_visit_date')
  renderDateInput('react_birthday')
  renderDateSearchInput()
}
