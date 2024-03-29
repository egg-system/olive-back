import React, { ChangeEvent } from 'react'
import FormControl from '@material-ui/core/FormControl'
import Select from '@material-ui/core/Select'
import MenuItem from '@material-ui/core/MenuItem'
import CircularProgress from '@material-ui/core/CircularProgress'
import SelectStyle from '../styles/AssignedStaffSelectInput.scss'

interface StaffJson {
  id: string
  last_name: string
  first_name: string
}

interface Staff {
  id: string
  name: string
}

interface SelectOption {
  label: string
  value: string
  disabled?: boolean
}

interface StaffSelectProp {
  selectedStaffOption: Staff | null
  reservationForm: JQuery<HTMLFormElement>
  disabled: boolean
  hint: string
}

interface StaffSelectState {
  selectedStaffId: string
  staffs: Staff[] | null
  selectedStaffOption: Staff | null
  disabled: boolean
  hint: string
  loading: boolean
}

const apiParamKeys = [
  { paramKey: 'store_id', formKey: /reservation\[store_id\]/ },
  { paramKey: 'reservation_date', formKey: /reservation\[reservation_date\]/ },
  { paramKey: 'reservation_start_time', formKey: /reservation\[start_time\]/ },
  {
    paramKey: 'reservation_menu_ids[]',
    formKey: /reservation\[reservation_details_attributes\]\[[1-9]\d*\]\[menu_id\]/
  },
  {
    paramKey: 'reservation_option_ids[]',
    formKey: /reservation\[reservation_details_attributes\]\[[1-9]\d*\]\[option_ids\]\[\]/
  },
]

export default class AssignableStaffSelect extends React.Component<
  StaffSelectProp,
  StaffSelectState
> {
  constructor(props: StaffSelectProp) {
    super(props)

    const selectedStaffId = props.selectedStaffOption
      ? props.selectedStaffOption.id
      : ''

    this.state = {
      selectedStaffId: selectedStaffId,
      staffs: null,
      selectedStaffOption: props.selectedStaffOption,
      disabled: props.disabled,
      hint: props.hint,
      loading: false
    }
  }

  private staffOptions = (): SelectOption[] => {
    if (this.state.selectedStaffOption) {
      return [
        { label: '担当スタッフを空にする', value: '' },
        {
          label: this.state.selectedStaffOption.name,
          value: this.state.selectedStaffOption.id
        }
      ]
    }

    if (!this.state.staffs) {
      return [{
        label: 'エラーが発生しました。',
        value: '',
        disabled: true
      }]
    }

    if (this.state.staffs.length === 0) {
      return [{
        label: 'シフトが空いている担当者がございません。',
        value: '',
        disabled: true
      }]
    }

    return this.state.staffs.map((staff) => {
      return { label: staff.name, value: staff.id }
    })
  }

  private fetchStaffOptions = async () => {
    const formValues = this.props.reservationForm.serializeArray()
    const params = apiParamKeys.map((param) => {
      const values = formValues.filter(formValue => {
        if (formValue.value === '') {
          return false
        }

        return param.formKey.test(formValue.name)
      })

      if (values.length > 1) {
        return values.map(value => `${param.paramKey}=${value.value}`).join('&')
      }

      return values.length > 0 ? `${param.paramKey}=${values[0].value}` : ''
    })

    try {
      this.setState({ loading: true })
      const response = await fetch(`/api/admin/staffs?${params.join('&')}`)
      const result = await response.json()
      const staffs = result.map((staff: StaffJson) => {
        return { id: staff.id, name: `${staff.last_name} ${staff.first_name}` }
      })
      this.setState({ staffs })
    } catch (error) {
      console.log('スタッフ取得時にエラーが発生しました。')
      console.log(error)
      this.setState({ staffs: null })
    } finally {
      this.setState({ loading: false })
    }
  }

  public componentDidMount = async () => {
    if (this.state.selectedStaffOption) {
      return
    }

    this.props.reservationForm.on('change', this.fetchStaffOptions)

    await this.fetchStaffOptions()
  }

  private handleSelectedStaffId = (
    event: ChangeEvent<{ name?: string | undefined, value: unknown }>
  ): void => {
    this.setState({ selectedStaffId: event.target.value as string })
  }

  public render() {
    return <FormControl disabled={ this.state.disabled }>
      <Select
        value={ this.state.selectedStaffId }
        onChange={ this.handleSelectedStaffId }
        disabled={ this.state.disabled }
        className={ SelectStyle.assignedStaffSelect }
        onClick={ this.fetchStaffOptions }
      >
        { this.state.loading && <MenuItem disabled>
          <CircularProgress />
        </MenuItem> }
        { 
          !this.state.loading
            && this.staffOptions().map((option) => {
              return <MenuItem
                key={ option.value }
                value={ option.value }
                disabled={ option.disabled }
              >
                { option.label }
              </MenuItem>
            })
        }
      </Select>
      {
        this.state.hint
          && <small className="form-text text-muted">
            { this.state.hint }
          </small>
      }
      <input
        type="hidden"
        name="reservation[staff_id]"
        value={ this.state.selectedStaffId }
      />
    </FormControl>
  }
}
