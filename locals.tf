# locals {
#   pages = {
#     "Main Page" = {
#       widget_bars = [
#         {
#           title  = "Average transaction duration, by application"
#           row    = 1
#           column = 7
#           width  = 6
#           height = 3
#           nrql_query = {
#             account_id = 12345
#             query      = "FROM Transaction SELECT average(duration) FACET appName"
#           }
#           colors = {
#             color = "#722727"
#             series_overrides = [
#               { color = "#722322", series_name = "Node" },
#               { color = "#236f70", series_name = "Java" }
#             ]
#           }
#           filter_current_dashboard = true
#         }
#       ]
#       widget_lines = [
#         {
#           title  = "Average transaction duration and the request per minute, by application"
#           row    = 4
#           column = 7
#           width  = 6
#           height = 3
#           nrql_queries = [
#             { query = "FROM Transaction select max(duration) as 'max duration' where httpResponseCode = '504' timeseries since 5 minutes ago" },
#             { query = "FROM Transaction SELECT rate(count(*), 1 minute)" }
#           ]
#           y_axis_right = {
#             y_axis_right_zero   = true
#             y_axis_right_min    = 0
#             y_axis_right_max    = 300
#             y_axis_right_series = ["A", "B"]
#           }
#           threshold = [
#             { name = "Duration Threshold", from = 1, to = 2, severity = "critical" },
#             { name = "Duration Threshold Two", from = 2.1, to = 3.3, severity = "warning" }
#           ]
#           units = {
#             unit = "ms"
#             series_overrides = [
#               { unit = "ms", series_name = "max duration" }
#             ]
#           }
#           null_values = {
#             null_value = "default"
#             series_overrides = [
#               { null_value = "remove", series_name = "Avg Cpu User Percent" },
#               { null_value = "zero", series_name = "Avg Cpu Idle Percent" },
#               { null_value = "default", series_name = "Avg Cpu IO Wait Percent" },
#               { null_value = "preserve", series_name = "Avg Cpu System Percent" }
#             ]
#           }
#         }
#       ]
#       widget_markdowns = [
#         {
#           title  = "Dashboard Note"
#           row    = 7
#           column = 1
#           width  = 12
#           height = 3
#           text   = "### Helpful Links\n\n* [New Relic One](https://one.newrelic.com)\n* [Developer Portal](https://developer.newrelic.com)"
#         }
#       ]
#     },
#     "Secondary Page" = {
#       widget_bars = [
#         {
#           title  = "Error Rate by Application"
#           row    = 1
#           column = 1
#           width  = 6
#           height = 3
#           nrql_query = {
#             account_id = 12345
#             query      = "FROM Transaction SELECT count(*) WHERE error IS true FACET appName"
#           }
#           colors = {
#             color = "#004d99"
#             series_overrides = [
#               { color = "#003366", series_name = "Service A" },
#               { color = "#66ccff", series_name = "Service B" }
#             ]
#           }
#           filter_current_dashboard = false
#         }
#       ]
#       widget_lines = [
#         {
#           title  = "Response Time and Throughput"
#           row    = 4
#           column = 1
#           width  = 6
#           height = 3
#           nrql_queries = [
#             { query = "FROM Transaction SELECT average(duration) AS 'Avg Duration' WHERE appName = 'Service A' TIMESERIES" },
#             { query = "FROM Transaction SELECT count(*) AS 'Throughput' WHERE appName = 'Service B' TIMESERIES" }
#           ]
#           y_axis_right = {
#             y_axis_right_zero   = false
#             y_axis_right_min    = null
#             y_axis_right_max    = 100
#             y_axis_right_series = ["Throughput"]
#           }
#           threshold = [
#             { name = "High Latency", from = 2, to = 4, severity = "critical" }
#           ]
#           units = {
#             unit = "ms"
#             series_overrides = [
#               { unit = "ms", series_name = "Avg Duration" }
#             ]
#           }
#           null_values = {
#             null_value = "default"
#             series_overrides = [
#               { null_value = "zero", series_name = "Throughput" }
#             ]
#           }
#         }
#       ]
#       widget_markdowns = [
#         {
#           title  = "Additional Information"
#           row    = 7
#           column = 1
#           width  = 12
#           height = 3
#           text   = "### Important Metrics\n\n* Ensure to monitor error rates and throughput frequently."
#         }
#       ]
#     }
#   }

#   variables = [
#     {
#       default_values     = ["value"]
#       is_multi_selection = true
#       item = {
#         title = "item"
#         value = "ITEM"
#       }
#       name = "variable"
#       nrql_query = {
#         account_ids = [12345]
#         query       = "FROM Transaction SELECT average(duration) FACET appName"
#       }
#       replacement_strategy = "default"
#       title                = "title"
#       type                 = "nrql"
#     }
#   ]
# }
