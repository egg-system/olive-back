import React, { Component } from 'react'
import { Moment } from 'moment'
import { uniq } from 'lodash'
import Tooltip from '@material-ui/core/Tooltip'

import styles from '../../../styles/ReservationCalendar.scss'

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

interface Props {
  shiftTime: string
  shifts: Shift[]
  reservations: Reservation[]
}

interface State {
  isOpen: boolean
}

export default class CalenderTime extends Component<Props, State> {
  constructor(props: Props) {
    super(props)

    this.state = { isOpen: false }
  }

  protected notReservedShifts() {
    return this.props.shifts.filter((shift) => {
      return this.props.reservations.every((reservation) => {
        return !reservation.shiftIds.includes(shift.id)
      })
    })
  }

  protected renderReservationRows() {
    const reservations = this.props.reservations
    if (reservations.length > 0) {
      return reservations.map((reservation) => {
        return <div
          key={ `${reservation.id}` }
          className={ styles.reservationRow }
        >
          <a href={ reservation.id ? `/reservations/${reservation.id}` : '' }>
            <div>患:{ reservation.customer.name }</div>
            <div>担:{ reservation.staff.name }</div>
          </a>
        </div>
      })
    }

    return null
  }

  protected handleIsOpen = () => {
    if (this.notReservedShifts().length === 0) {
      return
    }

    this.setState({
      isOpen: !this.state.isOpen
    })
  }

  render() {
    const shiftLabel = `${this.props.shiftTime}:00`
    // 1つの空枠につき、2つのシフトがあるため、2で割る
    const notResevedShift = this.notReservedShifts()
    const notResevedShiftCount = notResevedShift.length / 2

    const notResevedStaffNames = uniq(notResevedShift.map(shift => shift.staff.name))
    const notResevedStaffsElemant = notResevedStaffNames.map((staffName) => {
      return <div key={ staffName as string }>{ staffName }</div>
    })

    return <div className={ styles.calendarTimeRow }>
      <div className={ styles.calendarTimeHeader }>
        <div className={ styles.shiftLabel }>{ shiftLabel }</div>
        <div>
          (空：<Tooltip
            title={ notResevedStaffsElemant }
            open={ this.state.isOpen }
            PopperProps={{
              disablePortal: true,
            }}
            disableFocusListener
            disableHoverListener
            disableTouchListener
            arrow
          >
            <span
              className={ styles.NotReservedShiftCount }
              onClick={ this.handleIsOpen }
            >{ notResevedShiftCount }</span>
          </Tooltip>)
        </div>
      </div>
      <div className={ styles.reservationRows }>
        { this.renderReservationRows() }
      </div>
    </div>
  }
}
