import React from 'react'
import ReactDOM from 'react-dom'
import $ from 'jquery'
import AssignableStaffSelect from '../class/AssignableStaffSelect'

export const renderAssignableStaffSelect = () => {
  const element = $('#react_reservation_assignable_staff_select')
  if (Object.keys(element).length === 0) {
    return
  }

  const disabledValue = element.data('disabled')
  const hintValue = element.data('hint')
  const selectedStaff = element.data('selected-staff')
  const selectedStaffOption = selectedStaff
    ? {
      id: selectedStaff.id,
      name: `${selectedStaff.last_name} ${selectedStaff.first_name}`
    }
    : null
  const reservationFormId = element.data('reservation-from-id')
  const reservationForm = $(`#${reservationFormId}`) as JQuery<HTMLFormElement>

  ReactDOM.render(
    <AssignableStaffSelect
      selectedStaffOption={ selectedStaffOption }
      reservationForm={ reservationForm }
      disabled={ disabledValue }
      hint={ hintValue }
    />,
    // キャストしないと、ReactComponentが配列扱いになる
    element.get(0) as HTMLElement
  )
}
