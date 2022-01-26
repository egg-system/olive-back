import React, { Component, ChangeEvent } from 'react'
import { Summary } from "./Calendar/CalendarTime";

// import styles from '../../styles/Summary.scss'

interface SummaryProps {
  summary: Summary | null
}

export default class SummaryView extends Component<SummaryProps> {
  constructor(props: SummaryProps) {
    super(props)
  }

  private percentage(num: number | undefined) {
    if (num === undefined) {
      return ''
    }
    return this.floatFixed(num * 100, 1)
  }

  private floatFixed(num: number, fixed: number) {
    if (num === undefined) {
      return ''
    }

    return num.toFixed(fixed)
  }

  render() {
   return <div className="container-fluid my-3">
     <div className="row">
       <div className="col-3">
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>予約枠</div>
             <div>{ this.props.summary?.shiftCount }枠</div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>予約済み</div>
             <div>{ this.props.summary?.reserveCount }枠</div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>実質稼働率</div>
             <div>{ this.percentage(this.props.summary?.reserveRatioToday) }%</div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>月間稼働率</div>
             <div>{ this.percentage(this.props.summary?.reserveRatio) }%</div>
           </div>
         </div>
       </div>
       <div className="col-3">
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>経過率</div>
             <div></div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>売上合計</div>
             <div></div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>初診人数</div>
             <div></div>
           </div>
         </div>
       </div>
       <div className="col-3">
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>初診券付帯率</div>
             <div></div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>オプション付帯率</div>
             <div></div>
           </div>
         </div>
       </div>
       <div className="col-3">
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>初診5回券販売数</div>
             <div></div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>初診8回券販売数</div>
             <div></div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>通常5回券販売数</div>
             <div></div>
           </div>
         </div>
         <div className="row">
           <div className="col d-flex justify-content-between">
             <div>通常8回券販売数</div>
             <div></div>
           </div>
         </div>
       </div>
     </div>
   </div>
  }
}
