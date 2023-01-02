import React, { Fragment } from 'react'
import checkboxStyle from '../styles/ShiftCheckboxInput.scss'

interface ShiftCheckboxProp {
  shiftInputNames: string[]
  reservationExists: boolean
  checked: boolean
}

interface ShiftCheckboxState {
  shiftInputNames: string[]
  checked: boolean
  disabled: boolean
}

export default class ShiftCheckboxInput extends React.Component<
  ShiftCheckboxProp,
  ShiftCheckboxState
> {
  constructor(props: ShiftCheckboxProp) {
    super(props)

    this.state = {
      shiftInputNames: props.shiftInputNames,
      disabled: props.reservationExists,
      checked: props.checked
    }
  }

  private handleChecked = () => {
    this.setState({ checked: !this.state.checked })
  }

  public render() {
    return <div onClick={ this.handleChecked }>
      <input
        type="checkbox"
        onChange={ this.handleChecked }
        disabled={ this.state.disabled }
        checked={ this.state.checked }
      />
      {
        this.state.disabled &&
        <span>予約済み</span>
      }
      {
        this.state.shiftInputNames.map((inputName) => {
          return <input
            key={ inputName }
            type="hidden"
            name={ inputName }
            value={ this.state.checked ? 1 : 0 }
          />
        })
      }
    </div>
  }
}