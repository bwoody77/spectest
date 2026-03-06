// ChartDemo — demonstrates the Chart component with all four chart types.
//
// Chart is a built-in SVG-based data visualization component.
// It supports line, bar, area, pie, and donut chart types with zero
// external dependencies. Data is passed as an array of plain objects.
//
// Usage:
//   Chart(type: 'line', data: [...], xKey: 'month', yKey: 'sales')
//   Chart(type: 'pie', data: [...], labelKey: 'name', valueKey: 'amount', showValues: true)
//   Chart(type: 'bar', data: [...], xKey: 'product', series: [...], showLegend: true)

surface ChartDemo() {
  @state {
    activeChart: "line"
    showGrid: true
    showValues: false
  }

  @computed {
    isLine: activeChart == "line"
    isBar: activeChart == "bar"
    isArea: activeChart == "area"
    isPie: activeChart == "pie"
    isDonut: activeChart == "donut"
  }

  @actions {
    setChart(t) { activeChart = t }
    toggleGrid() { showGrid = !showGrid }
    toggleValues() { showValues = !showValues }
  }

  layout: vertical, gap: spacing.5

  text("Chart Component") { style: type.heading-lg, color: semantic.text-primary }
  text("Built-in SVG charts — no external library required. Supports line, bar, area, pie, and donut types.") {
    style: type.body-md
    color: semantic.text-secondary
  }

  // Chart type picker
  block {
    layout: horizontal, gap: spacing.2

    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isLine ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setChart("line")
      text("Line") { color: isLine ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isBar ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setChart("bar")
      text("Bar") { color: isBar ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isArea ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setChart("area")
      text("Area") { color: isArea ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isPie ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setChart("pie")
      text("Pie") { color: isPie ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isDonut ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setChart("donut")
      text("Donut") { color: isDonut ? "#fff" : semantic.text-primary }
    }
  }

  // ── Line Chart ──────────────────────────────────────────────────────────
  block {
    visibility: isLine
    Card() {
      block {
        padding: spacing.5
        layout: vertical, gap: spacing.4

        block {
          layout: horizontal, justify: "space-between", align: "center"
          text("Monthly Revenue") { style: type.heading-sm, color: semantic.text-primary }
          block {
            padding: "4px 10px"
            border-radius: radius.sm
            border: borders.default
            cursor: "pointer"
            background: showGrid ? semantic.primary : "transparent"
            on click: toggleGrid()
            text("Grid") { style: type.body-sm, color: showGrid ? "#fff" : semantic.text-secondary }
          }
        }

        Chart(
          type: "line",
          data: [
            {month: "Jan", revenue: 42000, target: 40000},
            {month: "Feb", revenue: 48000, target: 44000},
            {month: "Mar", revenue: 55000, target: 48000},
            {month: "Apr", revenue: 51000, target: 52000},
            {month: "May", revenue: 63000, target: 56000},
            {month: "Jun", revenue: 71000, target: 60000},
            {month: "Jul", revenue: 68000, target: 64000},
            {month: "Aug", revenue: 79000, target: 68000},
            {month: "Sep", revenue: 85000, target: 72000},
            {month: "Oct", revenue: 91000, target: 76000},
            {month: "Nov", revenue: 87000, target: 80000},
            {month: "Dec", revenue: 98000, target: 84000}
          ],
          xKey: "month",
          series: [
            {key: "revenue", label: "Revenue", color: "#6366f1"},
            {key: "target", label: "Target", color: "#10b981"}
          ],
          height: "280px",
          showGrid: showGrid,
          showLegend: true
        )

        text("Monthly revenue vs target. Multi-series line chart with legend.") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }
    }
  }

  // ── Bar Chart ────────────────────────────────────────────────────────────
  block {
    visibility: isBar
    Card() {
      block {
        padding: spacing.5
        layout: vertical, gap: spacing.4

        block {
          layout: horizontal, justify: "space-between", align: "center"
          text("Sales by Region") { style: type.heading-sm, color: semantic.text-primary }
          block {
            padding: "4px 10px"
            border-radius: radius.sm
            border: borders.default
            cursor: "pointer"
            background: showValues ? semantic.primary : "transparent"
            on click: toggleValues()
            text("Values") { style: type.body-sm, color: showValues ? "#fff" : semantic.text-secondary }
          }
        }

        Chart(
          type: "bar",
          data: [
            {region: "North",   q1: 23400, q2: 28100, q3: 31500, q4: 26800},
            {region: "South",   q1: 18700, q2: 21300, q3: 25600, q4: 22100},
            {region: "East",    q1: 31200, q2: 33800, q3: 38900, q4: 35400},
            {region: "West",    q1: 27600, q2: 29400, q3: 34200, q4: 31700},
            {region: "Central", q1: 15300, q2: 17800, q3: 20100, q4: 18500}
          ],
          xKey: "region",
          series: [
            {key: "q1", label: "Q1", color: "#6366f1"},
            {key: "q2", label: "Q2", color: "#10b981"},
            {key: "q3", label: "Q3", color: "#f59e0b"},
            {key: "q4", label: "Q4", color: "#ef4444"}
          ],
          height: "280px",
          showGrid: true,
          showValues: showValues,
          showLegend: true
        )

        text("Grouped bar chart — quarterly sales per region. Toggle Values for labels.") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }
    }
  }

  // ── Area Chart ───────────────────────────────────────────────────────────
  block {
    visibility: isArea
    Card() {
      block {
        padding: spacing.5
        layout: vertical, gap: spacing.4

        text("Active Users (Last 30 Days)") { style: type.heading-sm, color: semantic.text-primary }

        Chart(
          type: "area",
          data: [
            {day: "1",  users: 1200}, {day: "2",  users: 1350}, {day: "3",  users: 1180},
            {day: "4",  users: 1420}, {day: "5",  users: 1680}, {day: "6",  users: 1950},
            {day: "7",  users: 2100}, {day: "8",  users: 1870}, {day: "9",  users: 1640},
            {day: "10", users: 1820}, {day: "11", users: 2050}, {day: "12", users: 2280},
            {day: "13", users: 2150}, {day: "14", users: 2400}, {day: "15", users: 2650},
            {day: "16", users: 2480}, {day: "17", users: 2710}, {day: "18", users: 2890},
            {day: "19", users: 2730}, {day: "20", users: 3010}, {day: "21", users: 3250},
            {day: "22", users: 3080}, {day: "23", users: 3320}, {day: "24", users: 3150},
            {day: "25", users: 3480}, {day: "26", users: 3620}, {day: "27", users: 3390},
            {day: "28", users: 3750}, {day: "29", users: 3920}, {day: "30", users: 4100}
          ],
          xKey: "day",
          yKey: "users",
          color: "#6366f1",
          height: "280px",
          showGrid: true
        )

        text("Single-series area chart with filled region. Good for trends over time.") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }
    }
  }

  // ── Pie Chart ────────────────────────────────────────────────────────────
  block {
    visibility: isPie
    Card() {
      block {
        padding: spacing.5
        layout: vertical, gap: spacing.4

        block {
          layout: horizontal, justify: "space-between", align: "center"
          text("Revenue by Category") { style: type.heading-sm, color: semantic.text-primary }
          block {
            padding: "4px 10px"
            border-radius: radius.sm
            border: borders.default
            cursor: "pointer"
            background: showValues ? semantic.primary : "transparent"
            on click: toggleValues()
            text("Values") { style: type.body-sm, color: showValues ? "#fff" : semantic.text-secondary }
          }
        }

        Chart(
          type: "pie",
          data: [
            {category: "Software",   amount: 48200},
            {category: "Hardware",   amount: 31500},
            {category: "Services",   amount: 22800},
            {category: "Consulting", amount: 17400},
            {category: "Training",   amount: 9600}
          ],
          labelKey: "category",
          valueKey: "amount",
          height: "320px",
          showValues: showValues,
          showLegend: true
        )

        text("Pie chart with legend. Toggle Values to show amounts inside segments.") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }
    }
  }

  // ── Donut Chart ──────────────────────────────────────────────────────────
  block {
    visibility: isDonut
    Card() {
      block {
        padding: spacing.5
        layout: vertical, gap: spacing.4

        text("Task Status Distribution") { style: type.heading-sm, color: semantic.text-primary }

        Chart(
          type: "donut",
          data: [
            {status: "Done",        count: 142},
            {status: "In Progress", count: 38},
            {status: "Review",      count: 24},
            {status: "Blocked",     count: 11},
            {status: "Todo",        count: 67}
          ],
          labelKey: "status",
          valueKey: "count",
          colors: ["#10b981", "#6366f1", "#f59e0b", "#ef4444", "#6b7280"],
          height: "320px",
          showValues: true,
          showLegend: true
        )

        text("Donut chart — total shown in center ring. Good for part-to-whole relationships.") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }
    }
  }
}
