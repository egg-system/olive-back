import moment from "moment"
import MomentUtils from '@date-io/moment';
import { MaterialUiPickersDate } from "@material-ui/pickers/typings/date"

export default class MomnetJaUtils extends MomentUtils {
  getCalendarHeaderText(date: MaterialUiPickersDate) {
    const dateValue = date ? date : moment()
    return dateValue.format("YYYY年 MMM");
  }

  getDatePickerHeaderText(date: MaterialUiPickersDate) {
    const dateValue = date ? date : moment()
    return dateValue.format("MMMDD日");
  }
}
