connection: "flightstats"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: ontime {
  join: origin_airport {
    from:  airports

    type: left_outer
    relationship: many_to_one
    sql_on: ${ontime.origin} = ${origin_airport.code} ;;

  }

#   join: ontime {
#     type: left_outer
#     relationship: many_
#   }
}
