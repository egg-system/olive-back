import React, { Fragment } from 'react'

// material-uiのDateRangePickerが実装中のため、暫定でreact-datepickerを使用
import DatePicker from 'react-datepicker'
import "react-datepicker/dist/react-datepicker.css"

import TextField from '@material-ui/core/TextField'
import Dialog from '@material-ui/core/Dialog'
import DialogTitle from '@material-ui/core/DialogTitle'
import DialogContent from '@material-ui/core/DialogContent'
import DialogActions from '@material-ui/core/DialogActions'
import Grid from '@material-ui/core/Grid';
import Button from '@material-ui/core/Button'

// 日本語化のため使用
import ja from 'date-fns/locale/ja';

import moment, { Moment } from 'moment'

import calendarStyle from '../styles/CalendarSearchInput.scss'

interface CalendarSearchProp {
  startDateElement: HTMLInputElement
  endDateElement: HTMLInputElement
}

interface CalendarSearchState {
  startDateElement: HTMLInputElement
  endDateElement: HTMLInputElement
  dateRange: CalendarSearchRange
  isOpen: boolean
}

interface CalendarSearchRange {
  startDate: Date | null
  endDate: Date | null
}

export default class CalendarSearchInput extends React.Component<
  CalendarSearchProp,
  CalendarSearchState
> {
  constructor(props: CalendarSearchProp) {
    super(props);


    const startDateValue = props.startDateElement.value
    const startDate = startDateValue ? moment(startDateValue).toDate() : null

    const endDateValue = props.endDateElement.value
    const endDate = endDateValue ? moment(endDateValue).toDate() : null

    this.state = {
      startDateElement: props.startDateElement,
      endDateElement: props.endDateElement,
      isOpen: false,
      dateRange: { startDate, endDate }
    }
  }

  private handleDateRange = (dateRangeValue: [Date, Date]) => {
    const dateRange = {
      startDate: dateRangeValue[0],
      endDate: dateRangeValue[1],
    }
    this.setState({ dateRange })
  }

  private getDateRangeText = (): string => {
    const startDate = this.state.startDateElement.value
    const endDate = this.state.endDateElement.value

    if (!startDate && !endDate) {
      return ''
    }

    const startDateText = startDate ? moment(startDate).format('YYYY-MM-DD') : ''
    const endDateText = endDate ? moment(endDate).format('YYYY-MM-DD') : ''

    return `${startDateText} 〜 ${endDateText}`
  }

  private clearDateRange = () => {
    const startDateElement = this.state.startDateElement
    startDateElement.value = ''

    const endDateElement = this.state.endDateElement
    endDateElement.value = ''

    const isOpen = false
    const dateRange = { startDate: null, endDate: null }

    this.setState({
      startDateElement,
      endDateElement,
      isOpen,
      dateRange
    })
  }

  private commitDateRange = () => {
    const { startDate, endDate } = this.state.dateRange

    const startDateElement = this.state.startDateElement
    startDateElement.value = startDate ? moment(startDate).format('YYYY-MM-DD') : ''

    const endDateElement = this.state.endDateElement
    endDateElement.value = endDate ? moment(endDate).format('YYYY-MM-DD') : ''

    const isOpen = false
    this.setState({ startDateElement, endDateElement, isOpen })
  }

  private setDateRange = (startDate: Moment, endDate: Moment) => {
    this.setState({ dateRange: {
      startDate: startDate.toDate(),
      endDate: endDate.toDate()
    } })
  }

  public render() {
    const { startDate, endDate } = this.state.dateRange

    return <Fragment>
      <TextField
        className={ calendarStyle.textFieldInput }
        value={ this.getDateRangeText() }
        variant='outlined'
        onClick={ () => this.setState({ isOpen: true }) }
      />
      <Dialog open={ this.state.isOpen }>
        <DialogTitle>日付範囲の選択</DialogTitle>
        <DialogContent>
          <Grid container direction="row">
            <Grid item xs={ 10 }>
              <DatePicker
                startDate={ startDate }
                endDate={ endDate }
                onChange={ this.handleDateRange }
                selectsRange
                inline
                locale={ ja }
              />
            </Grid>
            <Grid item xs={ 2 }>
              <Grid container direction="column" alignItems="center" spacing={ 1 }>
                <Grid item>
                  <Button
                    variant="outlined"
                    onClick={ () => this.setDateRange(moment(), moment()) }>
                    今日
                  </Button>
                </Grid>
                <Grid item>
                  <Button
                    variant="outlined"
                    onClick={ () => this.setDateRange(
                      moment().add(1, 'days'),
                      moment().add(1, 'days')
                    )
                  }>
                    明日
                  </Button>
                </Grid>
                <Grid item>
                  <Button
                    variant="outlined"
                    onClick={ () => this.setDateRange(
                      moment().subtract(1, 'days'),
                      moment().subtract(1, 'days')
                    )
                  }>
                    昨日
                  </Button>
                </Grid>
                <Grid item>
                  <Button variant="outlined" onClick={ () => this.setDateRange(
                      moment().startOf('isoWeek'),
                      moment().endOf('isoWeek')
                    )
                  }>
                    今週
                  </Button>
                </Grid>
                <Grid item>
                  <Button
                    variant="outlined"
                    onClick={ () => this.setDateRange(
                      // moment.tsのsubtractがisoWeekに対応していないため、暫定対応
                      moment().startOf('isoWeek').subtract(1, 'days').startOf('isoWeek'),
                      moment().startOf('isoWeek').subtract(1, 'days').endOf('isoWeek')
                    )
                  }>
                    先週
                  </Button>
                </Grid>
                <Grid item>
                  <Button
                    variant="outlined"
                    onClick={ () => this.setDateRange(
                      moment().subtract(1, 'months').startOf('month'),
                      moment().subtract(1, 'months').endOf('month')
                    )
                  }>
                    先月
                  </Button>
                </Grid>
              </Grid>
            </Grid>
          </Grid>
        </DialogContent>
        <p className={ calendarStyle.searchDateText }>検索開始日：{
          this.state.dateRange.startDate
            && moment(this.state.dateRange.startDate).format('YYYY-MM-DD')
        }</p>
        <p className={ calendarStyle.searchDateText }>検索終了日：{
          this.state.dateRange.endDate
            && moment(this.state.dateRange.endDate).format('YYYY-MM-DD')
        }</p>
        <DialogActions>
          <Grid container justify="space-between">
            <Grid item>
              <Button
                variant="contained"
                color="secondary"
                onClick={ this.clearDateRange }
              >
                クリア
              </Button>
            </Grid>
            <Grid item>
              <Grid container alignItems="center" spacing={ 1 }>
                <Grid>
                  <Button
                    variant="contained"
                    color="primary"
                    onClick={ this.commitDateRange }
                  >
                    決定
                  </Button>
                </Grid>
                <Grid item>
                  <Button
                    variant="contained"
                    onClick={ () => this.setState({
                      isOpen: false,
                      dateRange: { startDate: null, endDate: null }
                    }) }
                  >
                    キャンセル
                  </Button>
                </Grid>
              </Grid>
            </Grid>
          </Grid>
        </DialogActions>
      </Dialog>
    </Fragment>
  }
}