# variable "newrelic_account_id" {
#   description = "New Relic account ID"
#   type        = string
# }

# variable "newrelic_api_key" {
#   description = "New Relic API key"
#   type        = string
# }

# variable "dashboard_name" {
#   description = "Name of the dashboard"
#   type        = string
# }

# variable "dashboard_permissions" {
#   description = "Permissions for the dashboard"
#   type        = string
# }

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
variable "newrelic_account_id" {
  description = "New Relic account ID"
  type        = string
}

variable "newrelic_api_key" {
  description = "New Relic API key"
  type        = string
}

variable "dashboard_name" {
  description = "Name of the dashboard"
  type        = string
}

variable "dashboard_permissions" {
  description = "Permissions for the dashboard"
  type        = string
}

variable "pages" {
  description = "Map of pages and their widgets"
  type = map(object({
    widget_bars = map(object({
      title                  = string
      row                    = number
      column                 = number
      width                  = number
      height                 = number
      nrql_query             = map(string)
      colors                 = object({
        color = string
        series_overrides = map(object({
          color       = string
          series_name = string
        }))
      })
      filter_current_dashboard = bool
    }))
    widget_lines = map(object({
      title                  = string
      row                    = number
      column                 = number
      width                  = number
      height                 = number
      nrql_queries           = map(object({
        query = string
      }))
      y_axis_right           = object({
        y_axis_right_zero   = bool
        y_axis_right_min    = number
        y_axis_right_max    = number
        y_axis_right_series = map(string)
      })
      threshold              = map(object({
        name      = string
        from      = string
        to        = string
        severity  = string
      }))
      units                  = object({
        unit               = string
        series_overrides    = map(object({
          unit         = string
          series_name  = string
        }))
      })
      null_values            = object({
        null_value          = string
        series_overrides    = map(object({
          null_value   = string
          series_name  = string
        }))
      })
    }))
    widget_markdowns = map(object({
      title                  = string
      row                    = number
      column                 = number
      width                  = number
      height                 = number
      text                   = string
    }))
  }))
}



variable "variables" {
  description = "Map of variables for the dashboard"
  type = map(object({
    default_values     = map(string)
    is_multi_selection = bool
    item               = object({
      title = string
      value = string
    })
    name               = string
    nrql_query         = object({
      account_ids = string
      query       = string
    })
    replacement_strategy = string
    title                = string
    type                 = string
  }))
}

