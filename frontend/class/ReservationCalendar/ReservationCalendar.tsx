import React, { Component } from 'react'
import moment, { Moment } from 'moment'

import SearchSelectInput, { Option, StoreOption } from './SearchSelectInput'
import CalendarView, { ReservationDateRange, Reservation, Shift } from './Calendar/CalendarView'

interface ReservationCalendarProps {
  stores: StoreOption[]
}

interface ReservationCalendarState {
  stores: StoreOption[]
  reservationDateRange: ReservationDateRange
  selectedStore: StoreOption
  selectedStaff: Option | null
  reservations: Reservation[]
  shifts: Shift[]
  loading: Boolean
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
        standardDate: moment().startOf('month'),
        startDate: rangeStartDate,
        endDate: rangeEndDate
      },
      loading: false,
      reservations: [],
      shifts: []
    }
  }

  private handleSelectedStore = (selectedId: string) => {
    const stores = this.state.stores
    const selectedStore = stores.find((store) => store.id === selectedId)

    this.setState({
      selectedStore: selectedStore as StoreOption,
      selectedStaff: null
    }, this.fetchReservationShifts)
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

    this.setState({ reservationDateRange }, this.fetchReservationShifts)
  }

  private fetchReservationShifts = async () => {
    const storeId = this.state.selectedStore.id
    const startDate = this.state.reservationDateRange.startDate.format('YYYY-MM-DD')
    const endDate = this.state.reservationDateRange.endDate.format('YYYY-MM-DD')

    const params = `store_id=${storeId}&start_date=${startDate}&end_date=${endDate}`

    try {
      this.setState({ loading: true })
      const response = await Promise.all([
        fetch(`/api/admin/shifts?${params}`),
        fetch(`/api/admin/reservations?${params}`),
      ])
      const shifts = await response[0].json()
      const reservations = await response[1].json()

      this.setState({ reservations, shifts })
    } catch (error) {
      console.log('予約の検索に失敗しました。')
      console.log(error)
    } finally {
      this.setState({ loading: false })
    }
  }

  private renderCalendarView = () => {
    const staffId = this.state.selectedStaff ? this.state.selectedStaff.id : null
    const filteredReservations = this.state.reservations.filter((reservation) => {
      return !staffId || reservation.staff.id === Number(staffId)
    })
    const filteredShifts = this.state.shifts.filter((shift) => {
      return !staffId || shift.staff.id === Number(staffId)
    })

    return <CalendarView
      loading={ this.state.loading }
      reservationDateRange={ this.state.reservationDateRange }
      handleReservationStandardDate={ this.handleReservationStandardDate }
      reservations={ filteredReservations }
      shifts={ filteredShifts }
    />
  }

  public componentDidMount = async () => {
    await this.fetchReservationShifts()
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
      <div>
        { this.renderCalendarView() }
      </div>
    </div>
  }
}
