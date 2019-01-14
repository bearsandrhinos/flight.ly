view: ontime {
  sql_table_name: public.ontime ;;

  dimension: arr_delay {
    type: number
    sql: ${TABLE}.arr_delay ;;
  }

  dimension_group: arr {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.arr_time ;;
  }

  dimension: cancelled {
    type: string
    sql: ${TABLE}.cancelled ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: dep_delay {
    type: number
    sql: ${TABLE}.dep_delay ;;
  }

  dimension: departure_status{
    type: string
    case: {
      when: {
        sql: ${dep_delay} <= 5 ;;
        label: "On time"
      }
      when: {
        sql: ${dep_delay} > 5 AND ${dep_delay} <= 30  ;;
        label: "Late"
      }
      else: "Very Late"
    }
#     order_by_field:
#     sql: CASE WHEN ${dep_delay} <= 5 THEN 'On time'
#               WHEN ${dep_delay} > 5 AND ${dep_delay} <= 30 THEN 'late'
#               ELSE 'Very Late' END ;;
  }

  dimension_group: dep {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.dep_time ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
  }

  dimension: diverted {
    type: string
    sql: ${TABLE}.diverted ;;
  }

  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
  }

  dimension: flight_time {
    type: number
    sql: ${TABLE}.flight_time ;;
  }

  dimension: id2 {
    type: number
    sql: ${TABLE}.id2 ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: tail_num {
    type: string
    sql: ${TABLE}.tail_num ;;
  }

  dimension: taxi_in {
    type: number
    sql: ${TABLE}.taxi_in ;;
  }

  dimension: taxi_out {
    type: number
    sql: ${TABLE}.taxi_out ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: ontime_flights {
    description: "Flight is on time if it leaves 5 minutes after scheduled departure or earlier"
    type: count
#     sql: ${id2} ;;
    filters: {
      field: dep_delay
      value: "<=5"
    }

  }

  measure: percantage_ontime_flight {
    type: number
    sql: 1.0*${ontime_flights}/nullif(${count},0) ;;
    value_format_name: percent_1
  }
}
