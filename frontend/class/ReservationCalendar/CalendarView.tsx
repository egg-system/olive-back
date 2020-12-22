import React, { Component } from 'react'
import { Moment } from 'moment'
import { chunk } from 'lodash'

export interface ReservationDateRange {
  standardDate: Moment
  startDate: Moment
  endDate: Moment
}

export interface Reservation {
  id: Number
  date: Moment
  startTime: String
  endTime: String
  customer: { id: Number, name: String }
  staff: { id: Number, name: String }
  shiftIds: Number[]
}

export interface Shift {
  id: Number
  date: Moment
  startTime: String
  endTime: String
  reservationId: Number
  staff: { id: Number, name: String }
}

interface CalendarViewProps {
  handleReservationStandardDate: (standardDate: Moment) => void
  reservationDateRange: ReservationDateRange
  reservations: Reservation[]
  shifts: Shift[]
}

export default class CalendarView extends Component<CalendarViewProps> {
  private getStandardDate() {
    return this.props.reservationDateRange.standardDate.clone()
  } 

  protected getYearMonthLabel() {
    const date = this.getStandardDate()
    return date.format('YYYY年 MM月')
  }

  protected renderDateCells() {
    const dateRange = this.props.reservationDateRange
    const currentDate = dateRange.startDate.clone()

    const standardMonth = dateRange.standardDate.month()
    const dates = []
    while (currentDate.unix() <= dateRange.endDate.unix()) {
      const inCurrentMonth = currentDate.month() === standardMonth
      const dateFormat = inCurrentMonth ? 'D' : 'M/D'

      dates.push(currentDate.format(dateFormat))
      currentDate.add(1, 'day')
    }

    return chunk(dates, 7).map((cells) => {
      const cellElements = cells.map((cell) => <div>{ cell }</div>)
      return <div>{ cellElements }</div>
    })
  }

  render() {
    return <div>
      <div>
        <div onClick={ () => {
          const date = this.getStandardDate()
          this.props.handleReservationStandardDate(date.subtract(1, 'month'))
        } }>&lt;</div>
        <div>{ this.getYearMonthLabel() }</div>
        <div onClick={ () => {
          const date = this.getStandardDate()
          this.props.handleReservationStandardDate(date.add(1, 'month'))
        } }>&gt;</div>
      </div>
      <div>{ this.renderDateCells() }</div>
    </div>
  }
}
