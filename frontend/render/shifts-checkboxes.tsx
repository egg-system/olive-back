import React from 'react'
import ReactDOM from 'react-dom'
import $ from 'jquery'
import ShiftCheckboxInput from '../class/ShiftCheckboxInput'

export const renderShiftCheckboxes = () => {
  // DOMの取得速度を落とさないため、idで取得する
  const shiftsTable = $('#shifts_table')
  if (Object.keys(shiftsTable).length === 0) {
    return
  }

  const shiftBoexes = $('#shifts_table [id^="react_shift_checkbox_"]')
  Array.from(shiftBoexes).forEach((element) => {
    const shiftInputNames = element.getAttribute('data-shift-input-names')
    const reservationExists = element.getAttribute('data-reservation-exsists')
    const checked = element.getAttribute('data-checked')

    if (!shiftInputNames || !reservationExists || !checked) {
      return
    }

    ReactDOM.render(
      <ShiftCheckboxInput
        shiftInputNames={ JSON.parse(shiftInputNames) }
        reservationExists={ reservationExists === 'true' }
        checked={ checked === 'true' }
      />,
      element
    )
  })
}
