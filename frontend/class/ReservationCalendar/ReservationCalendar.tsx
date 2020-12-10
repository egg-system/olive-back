import React, { Component } from 'react'
import moment, { Moment } from 'moment'

import SearchSelectInput, { Option, StoreOption } from './SearchSelectInput'
import Calendar, { ReservationDateRange, Reservation } from './Calendar'

interface ReservationCalendarProps {
  stores: StoreOption[]
}

interface ReservationCalendarState {
  stores: StoreOption[]
  reservationDateRange: ReservationDateRange
  selectedStore: StoreOption
  selectedStaff: Option | null
  reservations: Reservation[]
}

export default class ReservationCalendar extends Component<
  ReservationCalendarProps,
  ReservationCalendarState
> {
  constructor(props: ReservationCalendarProps) {
    super(props)

    const rangeStartDate = moment().startOf('month').startOf('week')
    const rangeEndDate = moment().endOf('month').endOf('week')

    this.state = {
      stores: props.stores,
      selectedStore: props.stores[0],
      selectedStaff: null,
      reservationDateRange: {
        standardDate: moment(),
        startDate: rangeStartDate,
        endDate: rangeEndDate
      },
      reservations: []
    }
  }

  private handleSelectedStore = (selectedId: string) => {
    const stores = this.state.stores
    const selectedStore = stores.find((store) => store.id === selectedId)

    this.setState({
      selectedStore: selectedStore as StoreOption,
      selectedStaff: null
    })
  }

  private handleSelectedStaff = (selectedId: string) => {
    const staffs = this.state.selectedStore.staffs
    const selectedStaff = staffs.find((staff) => staff.id === selectedId)

    const selectedStaffState = selectedStaff ? selectedStaff : null
    this.setState({ selectedStaff: selectedStaffState })
  }

  private handleReservationStandardDate = (standardDate: Moment) => {
    const reservationDateRange = {
      standardDate,
      startDate: standardDate.clone().startOf('month').startOf('week'),
      endDate: standardDate.clone().endOf('month').endOf('week')
    }

    this.setState({ reservationDateRange })
  }

  render() {
    return <div>
      <SearchSelectInput
        stores={ this.state.stores }
        selectedStore={ this.state.selectedStore }
        handleSelectedStore={ this.handleSelectedStore }
        selectedStaff={ this.state.selectedStaff }
        handleSelectedStaff={ this.handleSelectedStaff }
      />
      <Calendar
        reservationDateRange={ this.state.reservationDateRange }
        handleReservationStandardDate={ this.handleReservationStandardDate }
      />
    </div>
  }
}
