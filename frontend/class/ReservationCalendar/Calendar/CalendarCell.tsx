import React, { Component } from 'react'
import moment, { Moment } from 'moment'
import { sortBy, groupBy } from 'lodash'

import styles from '../../../styles/ReservationCalendar.scss'
import CalenderTime, { Reservation, Shift } from './CalendarTime'

export type { Reservation, Shift }

interface Props {
  date: Moment
  inStandardMonth: Boolean
  reservations: Reservation[]
  shifts: Shift[]
}

export default class CalendarCell extends Component<Props> {
  protected formatedDate() {
    const format = this.props.inStandardMonth ? 'D（ddd）' : 'M/D（ddd）'
    return this.props.date.format(format)
  }

  protected rendarTimeRows() {
    // 時間帯でシフトをまとめる
    const shiftTimes = groupBy(this.props.shifts, (shift) => {
      const startTime = moment(shift.startTime as string, 'HH:mm:ss')
      return startTime.hour()
    })

    // 連想配列にすると、キーが文字列になるので、数値に変換してソートする
    const sortedShiftTimes = sortBy(Object.keys(shiftTimes), Number)
    return sortedShiftTimes.map((shiftTime) => {
      const reservations = this.props.reservations.filter((reservation) => {
        const reservedTime = moment(reservation.startTime as string, 'HH:mm:ss')
        return reservedTime.hour() === Number(shiftTime)
      })

      return <CalenderTime
        key={ `${this.props.date.unix()}-${shiftTime}` }
        shiftTime={ shiftTime }
        shifts={ shiftTimes[shiftTime] }
        reservations={ reservations }
      />
    })
  }

  render() {
    const timeRowStyles = [styles.calendarCellDate]

    if (this.props.date.day() === 0) {
      timeRowStyles.push(styles.isSunday)
    }

    if (this.props.date.day() === 6) {
      timeRowStyles.push(styles.isSaturday)
    }

    return <div className={ styles.calendarCell }>
      <div className={ timeRowStyles.join(' ') }>
        { this.formatedDate() }
      </div>
      <div className={ styles.calendarTimeRows }>
        { this.rendarTimeRows() }
      </div>
    </div>
  }
}
