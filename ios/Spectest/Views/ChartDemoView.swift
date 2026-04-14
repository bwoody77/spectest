import SwiftUI
import SpecRuntime

@Observable
final class ChartDemoViewModel {
  var activeChart: Any = "line"
  var showGrid: Any = true
  var showValues: Any = false
  var isLine: Any { specEq(activeChart, "line") }
  var isBar: Any { specEq(activeChart, "bar") }
  var isArea: Any { specEq(activeChart, "area") }
  var isPie: Any { specEq(activeChart, "pie") }
  var isDonut: Any { specEq(activeChart, "donut") }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func setChart(_ t: Any) {
    activeChart = t
  }
  func toggleGrid() {
    showGrid = (!((showGrid) as? Bool ?? false))
  }
  func toggleValues() {
    showValues = (!((showValues) as? Bool ?? false))
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ChartDemoView: View {
  @State private var vm = ChartDemoViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      Text(verbatim: specString("Chart Component"))
        .font(.title2.bold())
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Built-in SVG charts — no external library required. Supports line, bar, area, pie, and donut types."))
        .font(.body.bold())
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
        Button(action: { vm.setChart("line") }) {
        VStack() {
          Text(verbatim: specString("Line"))
            .foregroundStyle(((vm.isLine) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .background(((vm.isLine) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.setChart("bar") }) {
        VStack() {
          Text(verbatim: specString("Bar"))
            .foregroundStyle(((vm.isBar) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .background(((vm.isBar) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.setChart("area") }) {
        VStack() {
          Text(verbatim: specString("Area"))
            .foregroundStyle(((vm.isArea) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .background(((vm.isArea) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.setChart("pie") }) {
        VStack() {
          Text(verbatim: specString("Pie"))
            .foregroundStyle(((vm.isPie) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .background(((vm.isPie) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.setChart("donut") }) {
        VStack() {
          Text(verbatim: specString("Donut"))
            .foregroundStyle(((vm.isDonut) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .background(((vm.isDonut) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
      }

      VStack() {
        if (vm.isLine) as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              HStack(alignment: .center) {
                Text(verbatim: specString("Monthly Revenue"))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Button(action: { vm.toggleGrid() }) {
                VStack() {
                  Text(verbatim: specString("Grid"))
                    .font(.callout.bold())
                    .foregroundStyle(((vm.showGrid) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-secondary")))
                }
                .background(((vm.showGrid) as? Bool ?? false ? ThemeManager.shared.color("primary") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                }
                .buttonStyle(.plain)
              }

              SpecChartView(
                type: specString("line"), data: [["month": "Jan" as Any, "revenue": 42000 as Any, "target": 40000 as Any] as [String: Any], ["month": "Feb" as Any, "revenue": 48000 as Any, "target": 44000 as Any] as [String: Any], ["month": "Mar" as Any, "revenue": 55000 as Any, "target": 48000 as Any] as [String: Any], ["month": "Apr" as Any, "revenue": 51000 as Any, "target": 52000 as Any] as [String: Any], ["month": "May" as Any, "revenue": 63000 as Any, "target": 56000 as Any] as [String: Any], ["month": "Jun" as Any, "revenue": 71000 as Any, "target": 60000 as Any] as [String: Any], ["month": "Jul" as Any, "revenue": 68000 as Any, "target": 64000 as Any] as [String: Any], ["month": "Aug" as Any, "revenue": 79000 as Any, "target": 68000 as Any] as [String: Any], ["month": "Sep" as Any, "revenue": 85000 as Any, "target": 72000 as Any] as [String: Any], ["month": "Oct" as Any, "revenue": 91000 as Any, "target": 76000 as Any] as [String: Any], ["month": "Nov" as Any, "revenue": 87000 as Any, "target": 80000 as Any] as [String: Any], ["month": "Dec" as Any, "revenue": 98000 as Any, "target": 84000 as Any] as [String: Any]] as [Any],
                xKey: specString("month"), yKey: specString("y"),
                labelKey: specString("label"), valueKey: specString("value"),
                series: [["key": "revenue" as Any, "label": "Revenue" as Any, "color": "#6366f1" as Any] as [String: Any], ["key": "target" as Any, "label": "Target" as Any, "color": "#10b981" as Any] as [String: Any]] as [Any], color: specString(""), colors: [] as [Any],
                title: specString(""), height: specPx("280px"),
                showGrid: vm.showGrid as? Bool ?? true,
                showValues: false as? Bool ?? false,
                showLegend: true as? Bool ?? true,
                yMin: nil, yMax: nil,
                connectNulls: false as? Bool ?? false,
                colorKey: specString(""),
                formatX: specString(""), formatY: specString("")
              )
              Text(verbatim: specString("Monthly revenue vs target. Multi-series line chart with legend."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if (vm.isBar) as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              HStack(alignment: .center) {
                Text(verbatim: specString("Sales by Region"))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Button(action: { vm.toggleValues() }) {
                VStack() {
                  Text(verbatim: specString("Values"))
                    .font(.callout.bold())
                    .foregroundStyle(((vm.showValues) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-secondary")))
                }
                .background(((vm.showValues) as? Bool ?? false ? ThemeManager.shared.color("primary") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                }
                .buttonStyle(.plain)
              }

              SpecChartView(
                type: specString("bar"), data: [["region": "North" as Any, "q1": 23400 as Any, "q2": 28100 as Any, "q3": 31500 as Any, "q4": 26800 as Any] as [String: Any], ["region": "South" as Any, "q1": 18700 as Any, "q2": 21300 as Any, "q3": 25600 as Any, "q4": 22100 as Any] as [String: Any], ["region": "East" as Any, "q1": 31200 as Any, "q2": 33800 as Any, "q3": 38900 as Any, "q4": 35400 as Any] as [String: Any], ["region": "West" as Any, "q1": 27600 as Any, "q2": 29400 as Any, "q3": 34200 as Any, "q4": 31700 as Any] as [String: Any], ["region": "Central" as Any, "q1": 15300 as Any, "q2": 17800 as Any, "q3": 20100 as Any, "q4": 18500 as Any] as [String: Any]] as [Any],
                xKey: specString("region"), yKey: specString("y"),
                labelKey: specString("label"), valueKey: specString("value"),
                series: [["key": "q1" as Any, "label": "Q1" as Any, "color": "#6366f1" as Any] as [String: Any], ["key": "q2" as Any, "label": "Q2" as Any, "color": "#10b981" as Any] as [String: Any], ["key": "q3" as Any, "label": "Q3" as Any, "color": "#f59e0b" as Any] as [String: Any], ["key": "q4" as Any, "label": "Q4" as Any, "color": "#ef4444" as Any] as [String: Any]] as [Any], color: specString(""), colors: [] as [Any],
                title: specString(""), height: specPx("280px"),
                showGrid: true as? Bool ?? true,
                showValues: vm.showValues as? Bool ?? false,
                showLegend: true as? Bool ?? true,
                yMin: nil, yMax: nil,
                connectNulls: false as? Bool ?? false,
                colorKey: specString(""),
                formatX: specString(""), formatY: specString("")
              )
              Text(verbatim: specString("Grouped bar chart — quarterly sales per region. Toggle Values for labels."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if (vm.isArea) as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Active Users (Last 30 Days)"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              SpecChartView(
                type: specString("area"), data: [["day": "1" as Any, "users": 1200 as Any] as [String: Any], ["day": "2" as Any, "users": 1350 as Any] as [String: Any], ["day": "3" as Any, "users": 1180 as Any] as [String: Any], ["day": "4" as Any, "users": 1420 as Any] as [String: Any], ["day": "5" as Any, "users": 1680 as Any] as [String: Any], ["day": "6" as Any, "users": 1950 as Any] as [String: Any], ["day": "7" as Any, "users": 2100 as Any] as [String: Any], ["day": "8" as Any, "users": 1870 as Any] as [String: Any], ["day": "9" as Any, "users": 1640 as Any] as [String: Any], ["day": "10" as Any, "users": 1820 as Any] as [String: Any], ["day": "11" as Any, "users": 2050 as Any] as [String: Any], ["day": "12" as Any, "users": 2280 as Any] as [String: Any], ["day": "13" as Any, "users": 2150 as Any] as [String: Any], ["day": "14" as Any, "users": 2400 as Any] as [String: Any], ["day": "15" as Any, "users": 2650 as Any] as [String: Any], ["day": "16" as Any, "users": 2480 as Any] as [String: Any], ["day": "17" as Any, "users": 2710 as Any] as [String: Any], ["day": "18" as Any, "users": 2890 as Any] as [String: Any], ["day": "19" as Any, "users": 2730 as Any] as [String: Any], ["day": "20" as Any, "users": 3010 as Any] as [String: Any], ["day": "21" as Any, "users": 3250 as Any] as [String: Any], ["day": "22" as Any, "users": 3080 as Any] as [String: Any], ["day": "23" as Any, "users": 3320 as Any] as [String: Any], ["day": "24" as Any, "users": 3150 as Any] as [String: Any], ["day": "25" as Any, "users": 3480 as Any] as [String: Any], ["day": "26" as Any, "users": 3620 as Any] as [String: Any], ["day": "27" as Any, "users": 3390 as Any] as [String: Any], ["day": "28" as Any, "users": 3750 as Any] as [String: Any], ["day": "29" as Any, "users": 3920 as Any] as [String: Any], ["day": "30" as Any, "users": 4100 as Any] as [String: Any]] as [Any],
                xKey: specString("day"), yKey: specString("users"),
                labelKey: specString("label"), valueKey: specString("value"),
                series: [] as [Any], color: specString("#6366f1"), colors: [] as [Any],
                title: specString(""), height: specPx("280px"),
                showGrid: true as? Bool ?? true,
                showValues: false as? Bool ?? false,
                showLegend: true as? Bool ?? true,
                yMin: nil, yMax: nil,
                connectNulls: false as? Bool ?? false,
                colorKey: specString(""),
                formatX: specString(""), formatY: specString("")
              )
              Text(verbatim: specString("Single-series area chart with filled region. Good for trends over time."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if (vm.isPie) as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              HStack(alignment: .center) {
                Text(verbatim: specString("Revenue by Category"))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Button(action: { vm.toggleValues() }) {
                VStack() {
                  Text(verbatim: specString("Values"))
                    .font(.callout.bold())
                    .foregroundStyle(((vm.showValues) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-secondary")))
                }
                .background(((vm.showValues) as? Bool ?? false ? ThemeManager.shared.color("primary") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                }
                .buttonStyle(.plain)
              }

              SpecChartView(
                type: specString("pie"), data: [["category": "Software" as Any, "amount": 48200 as Any] as [String: Any], ["category": "Hardware" as Any, "amount": 31500 as Any] as [String: Any], ["category": "Services" as Any, "amount": 22800 as Any] as [String: Any], ["category": "Consulting" as Any, "amount": 17400 as Any] as [String: Any], ["category": "Training" as Any, "amount": 9600 as Any] as [String: Any]] as [Any],
                xKey: specString("x"), yKey: specString("y"),
                labelKey: specString("category"), valueKey: specString("amount"),
                series: [] as [Any], color: specString(""), colors: [] as [Any],
                title: specString(""), height: specPx("320px"),
                showGrid: true as? Bool ?? true,
                showValues: vm.showValues as? Bool ?? false,
                showLegend: true as? Bool ?? true,
                yMin: nil, yMax: nil,
                connectNulls: false as? Bool ?? false,
                colorKey: specString(""),
                formatX: specString(""), formatY: specString("")
              )
              Text(verbatim: specString("Pie chart with legend. Toggle Values to show amounts inside segments."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if (vm.isDonut) as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              Text(verbatim: specString("Task Status Distribution"))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              SpecChartView(
                type: specString("donut"), data: [["status": "Done" as Any, "count": 142 as Any] as [String: Any], ["status": "In Progress" as Any, "count": 38 as Any] as [String: Any], ["status": "Review" as Any, "count": 24 as Any] as [String: Any], ["status": "Blocked" as Any, "count": 11 as Any] as [String: Any], ["status": "Todo" as Any, "count": 67 as Any] as [String: Any]] as [Any],
                xKey: specString("x"), yKey: specString("y"),
                labelKey: specString("status"), valueKey: specString("count"),
                series: [] as [Any], color: specString(""), colors: ["#10b981", "#6366f1", "#f59e0b", "#ef4444", "#6b7280"] as [Any],
                title: specString(""), height: specPx("320px"),
                showGrid: true as? Bool ?? true,
                showValues: true as? Bool ?? false,
                showLegend: true as? Bool ?? true,
                yMin: nil, yMax: nil,
                connectNulls: false as? Bool ?? false,
                colorKey: specString(""),
                formatX: specString(""), formatY: specString("")
              )
              Text(verbatim: specString("Donut chart — total shown in center ring. Good for part-to-whole relationships."))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .padding(ThemeManager.shared.size("spacing-5"))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
