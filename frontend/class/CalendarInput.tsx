import React from 'react'
import { DatePicker, MuiPickersUtilsProvider } from '@material-ui/pickers'
import { ThemeProvider } from '@material-ui/styles'
import { createMuiTheme } from '@material-ui/core/styles'

import moment from 'moment'
import { MaterialUiPickersDate } from "@material-ui/pickers/typings/date"

import momentJaUtils from '../utils/momentJaUtils'
import calendarInputStyle from '../styles/CalendarInput.scss'

interface CalendarProp {
  dateValueElement: HTMLInputElement
  isValid: Boolean
}

interface CalendarState {
  dateValueElement: HTMLInputElement
  isValid: Boolean
}

export default class CalendarInput extends React.Component<CalendarProp, CalendarState> {
  constructor(props: CalendarProp) {
    super(props);

    this.state = {
      dateValueElement: props.dateValueElement,
      isValid: props.isValid
    }
  }

  public handleDateValue = (value: MaterialUiPickersDate) => {
    this.state.dateValueElement.value = value ? value?.format('YYYY-MM-DD') : ''

    // 他のコンポーネントと連携しやすくするため、イベントを発生させる
    const changeEvent = new Event('change', { bubbles: true })
    this.state.dateValueElement.dispatchEvent(changeEvent)

    this.setState({ dateValueElement: this.state.dateValueElement })
  }

  protected getStyle = (errorMessage: string | null): string => {
    const styles = [calendarInputStyle.calendarInputGroup]

    if (errorMessage) {
      styles.push(calendarInputStyle.hasError)
    }

    if (this.state.isValid && !errorMessage) {
      styles.push(calendarInputStyle.isValid)
    }

    return styles.join(' ')
  }

  public render() {
    const dateValueElement = this.state.dateValueElement

    const dateValue = dateValueElement.value ? moment(dateValueElement.value) : null
    const errorMessage = dateValueElement.getAttribute('data-error')
    const clearable = dateValueElement.getAttribute('data-clearable')
    const disableFuture = dateValueElement.getAttribute('data-disable-future')
    const disablePast = dateValueElement.getAttribute('data-disable-past')
    const doSelectBirthDay = dateValueElement.getAttribute('data-select-birth-day')

    return <ThemeProvider
      theme={ createMuiTheme({ palette: { primary: { main: '#28a745' } } }) }
    >
      <MuiPickersUtilsProvider
        utils={ momentJaUtils }
        locale={ moment.locale('ja') }
      >
        <div className={ this.getStyle(errorMessage) }>
          <DatePicker 
            value={ dateValue }
            onChange={ this.handleDateValue }
            openTo={ doSelectBirthDay === 'true' ? 'year' : undefined }
            views={ doSelectBirthDay === 'true' ? ['year', 'month', 'date'] : undefined }
            disableFuture={ disableFuture === 'true' }
            disablePast={ disablePast === 'true' }
            clearable={ clearable === 'true' }
            disabled={ this.state.dateValueElement.disabled }
            inputVariant="outlined"
            format="YYYY-MM-DD"
            okLabel="決定"
            cancelLabel="キャンセル"
            clearLabel="クリア"
            animateYearScrolling
          />
          { this.state.dateValueElement.disabled &&
            <small className="form-text text-muted">
              担当スタッフを空にすると、日時の変更が可能になります。
            </small>
          }
          {
            errorMessage &&
            <div className={ calendarInputStyle.errorMessage }>
              { errorMessage }
            </div>
          }
        </div>
      </MuiPickersUtilsProvider>
    </ThemeProvider>
  }
}
