import React, { Component } from 'react'
import { Moment } from 'moment'
import { chunk } from 'lodash'
import CircularProgress from '@material-ui/core/CircularProgress'

import CalendarHeader, { ReservationDateRange } from './CalendarHeader'
import CalendarCell, { Reservation, Shift } from './CalendarCell'
import styles from '../../../styles/ReservationCalendar.scss'

export type { ReservationDateRange, Reservation, Shift }

interface CalendarViewProps {
  loading: Boolean
  handleReservationStandardDate: (standardDate: Moment) => void
  reservationDateRange: ReservationDateRange
  reservations: Reservation[]
  shifts: Shift[]
}

export default class CalendarView extends Component<CalendarViewProps> {
  protected renderCalendarRows() {
    if (this.props.loading) {
      return <div className={ styles.clandarLoadingWrapper }>
        <CircularProgress />
      </div>
    }

    const dateRange = this.props.reservationDateRange
    const currentDate = dateRange.startDate.clone()

    const dates = []
    while (currentDate.unix() <= dateRange.endDate.unix()) {
      dates.push(currentDate.clone())
      currentDate.add(1, 'day')
    }

    return chunk(dates, 7).map((dates, index) => {
      return <div className={ styles.calendarRow } key={ index }>
        { dates.map((date) => this.rendarCalendarCell(date)) }
      </div>
    })
  }

  protected rendarCalendarCell(date: Moment) {
    const dateRange = this.props.reservationDateRange
    const standardMonth = dateRange.standardDate.month() 
    const inStandardMonth = date.month() === standardMonth
    
    const reservations = this.props.reservations.filter((reservation) => {
      return date.isSame(reservation.date, 'day')
    })

    const shifts = this.props.shifts.filter((shift) => {
      return date.isSame(shift.date, 'day')
    })

    return <CalendarCell
      key={ date.unix() }
      date={ date }
      inStandardMonth={ inStandardMonth }
      reservations={ reservations }
      shifts={ shifts }
    />
  }

  render() {
    return <div className={ styles.calendarView }>
      <CalendarHeader
        reservationDateRange={ this.props.reservationDateRange }
        handleReservationStandardDate={ this.props.handleReservationStandardDate }
      />
      <div>
        { this.renderCalendarRows() }
      </div>
    </div>
  }
}
