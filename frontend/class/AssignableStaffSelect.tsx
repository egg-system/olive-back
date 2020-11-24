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

interface AssignedElement {
  key: string
  value: JQuery<HTMLInputElement>
}

interface StaffSelectProp {
  selectedStaffOption: Staff | null
  assignedElements: AssignedElement[]
  disabled: boolean
  hint: string
}

interface StaffSelectState {
  selectedStaffId: string
  staffs: Staff[] | null
  selectedStaffOption: Staff | null
  assignedElements: AssignedElement[]
  disabled: boolean
  hint: string
  loading: boolean
}

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
      assignedElements: props.assignedElements,
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
    const params = this.state.assignedElements.map((elementData) => {
      if (elementData.value.length === 1) {
        const paramValue = elementData.value.val()
        return `${elementData.key}=${paramValue}`
      }

      return elementData.value.get().filter((element) => {
        return element.checked
      }).flatMap((element) => {
        return `${elementData.key}=${element.value}`
      }).join('&')
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
    this.state.assignedElements.forEach((elementData) => {
      elementData.value.on('change', this.fetchStaffOptions)
    })

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
