import React from 'react'
import ReactDOM from 'react-dom'
import ReservationCalendar from '../class/ReservationCalendar/ReservationCalendar'

export const renderReservationCalendar = () => {
  const elementId = 'react_reservation_calendar'
  const element = document.getElementById(elementId)

  if (!element) {
    return
  }

  const storeStaffOptions = element.getAttribute('data-store-staffs') as string
  ReactDOM.render(
    <ReservationCalendar stores={ JSON.parse(storeStaffOptions) } />,
    element
  )
}
