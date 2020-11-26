import React from 'react'
import ReactDOM from 'react-dom'
import $ from 'jquery'
import AssignableStaffSelect from '../class/AssignableStaffSelect'

const assignedElementQueries = [
  { query: '#reservation_store_id', key: 'store_id' },
  { query: '#react_reservation_date_value', key: 'reservation_date' },
  { query: '#reservation_start_time', key: 'reseravtion_start_time' },
  {
    query: '[id^="reservation_reservation_details_attributes_"][id$="_menu_id"]',
    key: 'reservation_menu_ids[]'
  },
  {
    query: '[id^="reservation_reservation_details_attributes_"][id*="_option_ids_"]',
    key: 'reservation_option_ids[]'
  },
]

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
  const assignedElements = assignedElementQueries.map((element) => {
    return {
      key: element.key,
      value: $(element.query) as JQuery<HTMLInputElement>
    }
  })

  ReactDOM.render(
    <AssignableStaffSelect
      selectedStaffOption={ selectedStaffOption }
      assignedElements={ assignedElements }
      disabled={ disabledValue }
      hint={ hintValue }
    />,
    element.get(0)
  )
}
