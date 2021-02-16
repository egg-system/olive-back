import React, { Component, ChangeEvent } from 'react'

import InputLabel from '@material-ui/core/InputLabel'
import Select from '@material-ui/core/Select'
import MenuItem from '@material-ui/core/MenuItem'

import styles from '../../styles/ReservationCalendar.scss'

export interface Option {
  id: string
  name: string
}

export interface StoreOption extends Option {
  staffs: Option[]
}

interface SearchSelectProps {
  stores: StoreOption[]
  selectedStore: StoreOption
  handleSelectedStore: (storeId: string) => void
  selectedStaff: Option | null
  handleSelectedStaff: (staffId: string) => void
}

export default class SearchSelectInput extends Component<SearchSelectProps> {
  constructor(props: SearchSelectProps) {
    super(props)
  }

  protected handleSelectedStore =(
    event: ChangeEvent<{ name?: string | undefined, value: unknown }>
  ) => {
    const storeId = event.target.value as string
    this.props.handleSelectedStore(storeId)
  }

  protected handleSelectedStaff = (
    event: ChangeEvent<{ name?: string | undefined, value: unknown }>
  ) => {
    const staffId = event.target.value as string
    this.props.handleSelectedStaff(staffId)
  }

  private getMenuItems(options: Option[]) {
    return options.map((option) => {
      return <MenuItem value={ option.id } key={ option.id }>
        { option.name }
      </MenuItem> 
    })
  }

  protected getStoreSelectInput() {
    return <Select
      value={ this.props.selectedStore.id }
      onChange={ this.handleSelectedStore }
    >
      { this.getMenuItems(this.props.stores) }
    </Select>
  }

  protected getStaffSelectInput() {
    const staffs = this.props.selectedStore.staffs
    const menuItems = this.getMenuItems(staffs)

    // 基本、keyはidにしているため、全件検索はallはかぶらない見込み
    menuItems.unshift(<MenuItem key="all">全件検索</MenuItem>)

    const selectedStaff = this.props.selectedStaff
    const selectValue = selectedStaff ?  selectedStaff.id : ''

    return <Select
      value={ selectValue }
      onChange={ this.handleSelectedStaff }
    >
      { menuItems }
    </Select>
  }

  render() {
   return <div className={ styles.searchSelects }>
      <div className={ styles.searchHeader }>検索</div>
      <div>
        <div className={ styles.selectInput }>
          <InputLabel>店舗</InputLabel>
          { this.getStoreSelectInput() }
        </div>
        <div className={ styles.selectInput }>
          <InputLabel>スタッフ</InputLabel>
          { this.getStaffSelectInput() }
        </div>
      </div>
    </div>
  }
}
