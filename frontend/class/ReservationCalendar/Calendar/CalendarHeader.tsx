import React, { Component } from 'react'
import { Moment } from 'moment'

import styles from '../../../styles/ReservationCalendar.scss'

export interface ReservationDateRange {
  standardDate: Moment
  startDate: Moment
  endDate: Moment
}

interface Props {
  reservationDateRange: ReservationDateRange
  handleReservationStandardDate: (standardDate: Moment) => void
}

export default class CalendarHeader extends Component<Props> {
  private getStandardDate() {
    return this.props.reservationDateRange.standardDate.clone()
  } 

  protected getYearMonthLabel() {
    const date = this.getStandardDate()
    return date.format('YYYY年 MM月')
  }

  render() {
    return <div className={ styles.calendarHeader }>
      <div
        className={ styles.calendarHeaderLink }
        onClick={ () => {
          const date = this.getStandardDate()
          this.props.handleReservationStandardDate(date.subtract(1, 'month'))
        } }
      >&lt;</div>
      <div>{ this.getYearMonthLabel() }</div>
      <div
        className={ styles.calendarHeaderLink }
        onClick={ () => {
          const date = this.getStandardDate()
          this.props.handleReservationStandardDate(date.add(1, 'month'))
        } }
      >&gt;</div>
    </div>
  }
}
