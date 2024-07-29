# newrelic_account_id = 4438266
# newrelic_api_key     = "NRAK-FHKRNTXMEACHLUC4ONZ2E1XF2ZC"
# dashboard_name      = "New Relic Terraform Example"
# dashboard_permissions = "public_read_only"
# terraform.tfvars

newrelic_account_id = 4438266
newrelic_api_key = "NRAK-FHKRNTXMEACHLUC4ONZ2E1XF2ZC"

dashboard_name = "My Dashboard"
dashboard_permissions = "public_read_only"

pages = {
  "Main Page" = {
    widget_bars = {
      "bar_widget_1" = {
        title                  = "Average transaction duration, by application"
        row                    = 1
        column                 = 7
        width                  = 6
        height                 = 3
        nrql_query = {
          account_id = "4438266"
          query      = "FROM Transaction SELECT average(duration) FACET appName"
        }
        colors = {
          color = "#722727"
          series_overrides = {
            "override_1" = { color = "#722322", series_name = "Node" }
            "override_2" = { color = "#236f70", series_name = "Java" }
          }
        }
        filter_current_dashboard = true
      }
    }
    widget_lines = {
      "line_widget_1" = {
        title  = "Average transaction duration and the request per minute, by application"
        row    = 4
        column = 7
        width  = 6
        height = 3
        nrql_queries = {
          "query_1" = { query = "FROM Transaction select max(duration) as 'max duration' where httpResponseCode = '504' timeseries since 5 minutes ago" }
          "query_2" = { query = "FROM Transaction SELECT rate(count(*), 1 minute)" }
        }
        y_axis_right = {
          y_axis_right_zero   = true
          y_axis_right_min    = 0
          y_axis_right_max    = 300
          y_axis_right_series = {
            "series_1" = "Throughput"
            "series_2" = "Avg Duration"
          }
        }
        threshold = {
          "threshold_1" = { name = "Duration Threshold", from = "1", to = "2", severity = "critical" }
          "threshold_2" = { name = "Duration Threshold Two", from = "2.1", to = "3.3", severity = "warning" }
        }
        units = {
          unit = "ms"
          series_overrides = {
            "override_1" = { unit = "ms", series_name = "max duration" }
          }
        }
        null_values = {
          null_value = "default"
          series_overrides = {
            "override_1" = { null_value = "remove", series_name = "Avg Cpu User Percent" }
            "override_2" = { null_value = "zero", series_name = "Avg Cpu Idle Percent" }
            "override_3" = { null_value = "default", series_name = "Avg Cpu IO Wait Percent" }
            "override_4" = { null_value = "preserve", series_name = "Avg Cpu System Percent" }
          }
        }
      }
    }
    widget_markdowns = {
      "markdown_widget_1" = {
        title  = "Dashboard Note"
        row    = 7
        column = 1
        width  = 12
        height = 3
        text   = "### Helpful Links\n\n* [New Relic One](https://one.newrelic.com)\n* [Developer Portal](https://developer.newrelic.com)"
      }
    }
  },

  "Secondary Page" = {
    widget_bars = {
      "bar_widget_1" = {
        title  = "Error Rate by Application"
        row    = 1
        column = 1
        width  = 6
        height = 3
        nrql_query = {
          account_id = "4438266"
          query      = "FROM Transaction SELECT count(*) WHERE error IS true FACET appName"
        }
        colors = {
          color = "#004d99"
          series_overrides = {
            "override_1" = { color = "#003366", series_name = "Service A" }
            "override_2" = { color = "#66ccff", series_name = "Service B" }
          }
        }
        filter_current_dashboard = false
      }
    }
    widget_lines = {
      "line_widget_1" = {
        title  = "Response Time and Throughput"
        row    = 4
        column = 1
        width  = 6
        height = 3
        nrql_queries = {
          "query_1" = { query = "FROM Transaction SELECT average(duration) AS 'Avg Duration' WHERE appName = 'Service A' TIMESERIES" }
          "query_2" = { query = "FROM Transaction SELECT count(*) AS 'Throughput' WHERE appName = 'Service B' TIMESERIES" }
        }
        y_axis_right = {
          y_axis_right_zero   = false
          y_axis_right_min    = 0
          y_axis_right_max    = 100
          y_axis_right_series = {
            "series_1" = "Throughput"
          }
        }
        threshold = {
          "threshold_1" = { name = "High Latency", from = "2", to = "4", severity = "critical" }
        }
        units = {
          unit = "ms"
          series_overrides = {
            "override_1" = { unit = "ms", series_name = "Avg Duration" }
          }
        }
        null_values = {
          null_value = "default"
          series_overrides = {
            "override_1" = { null_value = "zero", series_name = "Throughput" }
          }
        }
      }
    }
    widget_markdowns = {
      "markdown_widget_1" = {
        title  = "Additional Information"
        row    = 7
        column = 1
        width  = 12
        height = 3
        text   = "### Important Metrics\n\n* Ensure to monitor error rates and throughput frequently."
      }
    }
  }
}

variables = {
  "variable_1" = {
    default_values     = { "key1" = "value1", "key2" = "value2" }
    is_multi_selection = true
    item               = { title = "Item Title", value = "Item Value" }
    name               = "hello"
    nrql_query         = { account_ids = "4438266", query = "SELECT count(*) FROM Transaction" }
    replacement_strategy = "default"
    title              = "title"
    type               = "string"
  }
}
