
resource "newrelic_one_dashboard" "exampledash" {
  name        = "New Relic Terraform Example"
  permissions = "public_read_only"

  dynamic "page" {
    for_each = var.pages
    content {
      name = page.key

      dynamic "widget_bar" {
        for_each = page.value.widget_bars
        content {
          title                  = widget_bar.value.title
          row                    = widget_bar.value.row
          column                 = widget_bar.value.column
          width                  = widget_bar.value.width
          height                 = widget_bar.value.height

          nrql_query {
            query = widget_bar.value.nrql_query.query
            account_id = lookup(widget_bar.value.nrql_query, "account_id", null)
          }

          colors {
            color = widget_bar.value.colors.color
            # Note: series_overrides removed as it's unsupported
          }

          filter_current_dashboard = widget_bar.value.filter_current_dashboard
        }
      }

      dynamic "widget_line" {
        for_each = page.value.widget_lines
        content {
          title  = widget_line.value.title
          row    = widget_line.value.row
          column = widget_line.value.column
          width  = widget_line.value.width
          height = widget_line.value.height

          dynamic "nrql_query" {
            for_each = widget_line.value.nrql_queries
            content {
              query = nrql_query.value.query
            }
          }

          y_axis_right {
            y_axis_right_zero   = widget_line.value.y_axis_right.y_axis_right_zero
            y_axis_right_min    = widget_line.value.y_axis_right.y_axis_right_min
            y_axis_right_max    = widget_line.value.y_axis_right.y_axis_right_max
            y_axis_right_series = values(widget_line.value.y_axis_right.y_axis_right_series)
          }

          dynamic "threshold" {
            for_each = widget_line.value.threshold
            content {
              name      = threshold.value.name
              from      = threshold.value.from
              to        = threshold.value.to
              severity  = threshold.value.severity
            }
          }

          units {
            unit = widget_line.value.units.unit
            
          }

          null_values {
            null_value = widget_line.value.null_values.null_value
            
          }
        }
      }

      dynamic "widget_markdown" {
        for_each = page.value.widget_markdowns
        content {
          title  = widget_markdown.value.title
          row    = widget_markdown.value.row
          column = widget_markdown.value.column
          width  = widget_markdown.value.width
          height = widget_markdown.value.height
          text   = widget_markdown.value.text
        }
      }
    }
  }

  dynamic "variable" {
    for_each = var.variables
    content {
      default_values     = tolist(values(variable.value.default_values))
      is_multi_selection = variable.value.is_multi_selection
      item {
        title = variable.value.item.title
        value = variable.value.item.value
      }
      name               = variable.value.name
      nrql_query {
        account_ids = tolist([for id in split(",", variable.value.nrql_query.account_ids) : tonumber(id)])
        query       = variable.value.nrql_query.query
      }
      replacement_strategy = lookup(variable.value, "replacement_strategy", "default")
      title                = variable.value.title
      type                 = lookup(variable.value, "type", "string")
    }
  }
}
