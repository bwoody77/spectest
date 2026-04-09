import SwiftUI
import SpecRuntime

@Observable
final class ChartDemoViewModel {
  var activeChart: Any = "line"
  var showGrid: Any = true
  var showValues: Any = false
  var isLine: Any { (specString(activeChart) == specString("line")) }
  var isBar: Any { (specString(activeChart) == specString("bar")) }
  var isArea: Any { (specString(activeChart) == specString("area")) }
  var isPie: Any { (specString(activeChart) == specString("pie")) }
  var isDonut: Any { (specString(activeChart) == specString("donut")) }
  func setChart(_ t: Any) {
    activeChart = t
  }
  func toggleGrid() {
    showGrid = !(showGrid as? Bool ?? false)
  }
  func toggleValues() {
    showValues = !(showValues as? Bool ?? false)
  }
}

struct ChartDemoView: View {
  @State private var vm = ChartDemoViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(specString("Chart Component"))
        .font(.title2.bold())
        .foregroundStyle(.primary)
      Text(specString("Built-in SVG charts — no external library required. Supports line, bar, area, pie, and donut types."))
        .font(.body.bold())
        .foregroundStyle(.secondary)
      HStack(alignment: .center, spacing: CGFloat(8)) {
        VStack() {
          Text(specString("Line"))
            .foregroundStyle(Color(hex: ((vm.isLine) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isLine) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setChart("line") }
        VStack() {
          Text(specString("Bar"))
            .foregroundStyle(Color(hex: ((vm.isBar) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isBar) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setChart("bar") }
        VStack() {
          Text(specString("Area"))
            .foregroundStyle(Color(hex: ((vm.isArea) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isArea) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setChart("area") }
        VStack() {
          Text(specString("Pie"))
            .foregroundStyle(Color(hex: ((vm.isPie) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isPie) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setChart("pie") }
        VStack() {
          Text(specString("Donut"))
            .foregroundStyle(Color(hex: ((vm.isDonut) as? Bool ?? false ? "#fff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((vm.isDonut) as? Bool ?? false ? "#1677ff" : "#ffffff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        .onTapGesture { vm.setChart("donut") }
      }

      VStack() {
        if vm.isLine as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              HStack(alignment: .center, ) {
                Text(specString("Monthly Revenue"))
                  .font(.headline.bold())
                  .foregroundStyle(.primary)
                VStack() {
                  Text(specString("Grid"))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: ((vm.showGrid) as? Bool ?? false ? "#fff" : "#496183") as? String ?? "#000"))
                }
                .padding(CGFloat(0))
                .background(Color(hex: ((vm.showGrid) as? Bool ?? false ? "#1677ff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(6)))
                .onTapGesture { vm.toggleGrid() }
              }

              ChartView(data: [["month": "Jan" as Any, "revenue": 42000 as Any, "target": 40000 as Any] as [String: Any], ["month": "Feb" as Any, "revenue": 48000 as Any, "target": 44000 as Any] as [String: Any], ["month": "Mar" as Any, "revenue": 55000 as Any, "target": 48000 as Any] as [String: Any], ["month": "Apr" as Any, "revenue": 51000 as Any, "target": 52000 as Any] as [String: Any], ["month": "May" as Any, "revenue": 63000 as Any, "target": 56000 as Any] as [String: Any], ["month": "Jun" as Any, "revenue": 71000 as Any, "target": 60000 as Any] as [String: Any], ["month": "Jul" as Any, "revenue": 68000 as Any, "target": 64000 as Any] as [String: Any], ["month": "Aug" as Any, "revenue": 79000 as Any, "target": 68000 as Any] as [String: Any], ["month": "Sep" as Any, "revenue": 85000 as Any, "target": 72000 as Any] as [String: Any], ["month": "Oct" as Any, "revenue": 91000 as Any, "target": 76000 as Any] as [String: Any], ["month": "Nov" as Any, "revenue": 87000 as Any, "target": 80000 as Any] as [String: Any], ["month": "Dec" as Any, "revenue": 98000 as Any, "target": 84000 as Any] as [String: Any]] as [Any], height: "280px", series: [["key": "revenue" as Any, "label": "Revenue" as Any, "color": "#6366f1" as Any] as [String: Any], ["key": "target" as Any, "label": "Target" as Any, "color": "#10b981" as Any] as [String: Any]] as [Any], showGrid: vm.showGrid, showLegend: true, type: "line", xKey: "month")
              Text(specString("Monthly revenue vs target. Multi-series line chart with legend."))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if vm.isBar as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              HStack(alignment: .center, ) {
                Text(specString("Sales by Region"))
                  .font(.headline.bold())
                  .foregroundStyle(.primary)
                VStack() {
                  Text(specString("Values"))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: ((vm.showValues) as? Bool ?? false ? "#fff" : "#496183") as? String ?? "#000"))
                }
                .padding(CGFloat(0))
                .background(Color(hex: ((vm.showValues) as? Bool ?? false ? "#1677ff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(6)))
                .onTapGesture { vm.toggleValues() }
              }

              ChartView(data: [["region": "North" as Any, "q1": 23400 as Any, "q2": 28100 as Any, "q3": 31500 as Any, "q4": 26800 as Any] as [String: Any], ["region": "South" as Any, "q1": 18700 as Any, "q2": 21300 as Any, "q3": 25600 as Any, "q4": 22100 as Any] as [String: Any], ["region": "East" as Any, "q1": 31200 as Any, "q2": 33800 as Any, "q3": 38900 as Any, "q4": 35400 as Any] as [String: Any], ["region": "West" as Any, "q1": 27600 as Any, "q2": 29400 as Any, "q3": 34200 as Any, "q4": 31700 as Any] as [String: Any], ["region": "Central" as Any, "q1": 15300 as Any, "q2": 17800 as Any, "q3": 20100 as Any, "q4": 18500 as Any] as [String: Any]] as [Any], height: "280px", series: [["key": "q1" as Any, "label": "Q1" as Any, "color": "#6366f1" as Any] as [String: Any], ["key": "q2" as Any, "label": "Q2" as Any, "color": "#10b981" as Any] as [String: Any], ["key": "q3" as Any, "label": "Q3" as Any, "color": "#f59e0b" as Any] as [String: Any], ["key": "q4" as Any, "label": "Q4" as Any, "color": "#ef4444" as Any] as [String: Any]] as [Any], showGrid: true, showLegend: true, showValues: vm.showValues, type: "bar", xKey: "region")
              Text(specString("Grouped bar chart — quarterly sales per region. Toggle Values for labels."))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if vm.isArea as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Active Users (Last 30 Days)"))
                .font(.headline.bold())
                .foregroundStyle(.primary)
              ChartView(color: "#6366f1", data: [["day": "1" as Any, "users": 1200 as Any] as [String: Any], ["day": "2" as Any, "users": 1350 as Any] as [String: Any], ["day": "3" as Any, "users": 1180 as Any] as [String: Any], ["day": "4" as Any, "users": 1420 as Any] as [String: Any], ["day": "5" as Any, "users": 1680 as Any] as [String: Any], ["day": "6" as Any, "users": 1950 as Any] as [String: Any], ["day": "7" as Any, "users": 2100 as Any] as [String: Any], ["day": "8" as Any, "users": 1870 as Any] as [String: Any], ["day": "9" as Any, "users": 1640 as Any] as [String: Any], ["day": "10" as Any, "users": 1820 as Any] as [String: Any], ["day": "11" as Any, "users": 2050 as Any] as [String: Any], ["day": "12" as Any, "users": 2280 as Any] as [String: Any], ["day": "13" as Any, "users": 2150 as Any] as [String: Any], ["day": "14" as Any, "users": 2400 as Any] as [String: Any], ["day": "15" as Any, "users": 2650 as Any] as [String: Any], ["day": "16" as Any, "users": 2480 as Any] as [String: Any], ["day": "17" as Any, "users": 2710 as Any] as [String: Any], ["day": "18" as Any, "users": 2890 as Any] as [String: Any], ["day": "19" as Any, "users": 2730 as Any] as [String: Any], ["day": "20" as Any, "users": 3010 as Any] as [String: Any], ["day": "21" as Any, "users": 3250 as Any] as [String: Any], ["day": "22" as Any, "users": 3080 as Any] as [String: Any], ["day": "23" as Any, "users": 3320 as Any] as [String: Any], ["day": "24" as Any, "users": 3150 as Any] as [String: Any], ["day": "25" as Any, "users": 3480 as Any] as [String: Any], ["day": "26" as Any, "users": 3620 as Any] as [String: Any], ["day": "27" as Any, "users": 3390 as Any] as [String: Any], ["day": "28" as Any, "users": 3750 as Any] as [String: Any], ["day": "29" as Any, "users": 3920 as Any] as [String: Any], ["day": "30" as Any, "users": 4100 as Any] as [String: Any]] as [Any], height: "280px", showGrid: true, type: "area", xKey: "day", yKey: "users")
              Text(specString("Single-series area chart with filled region. Good for trends over time."))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if vm.isPie as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              HStack(alignment: .center, ) {
                Text(specString("Revenue by Category"))
                  .font(.headline.bold())
                  .foregroundStyle(.primary)
                VStack() {
                  Text(specString("Values"))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: ((vm.showValues) as? Bool ?? false ? "#fff" : "#496183") as? String ?? "#000"))
                }
                .padding(CGFloat(0))
                .background(Color(hex: ((vm.showValues) as? Bool ?? false ? "#1677ff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(6)))
                .onTapGesture { vm.toggleValues() }
              }

              ChartView(data: [["category": "Software" as Any, "amount": 48200 as Any] as [String: Any], ["category": "Hardware" as Any, "amount": 31500 as Any] as [String: Any], ["category": "Services" as Any, "amount": 22800 as Any] as [String: Any], ["category": "Consulting" as Any, "amount": 17400 as Any] as [String: Any], ["category": "Training" as Any, "amount": 9600 as Any] as [String: Any]] as [Any], height: "320px", labelKey: "category", showLegend: true, showValues: vm.showValues, type: "pie", valueKey: "amount")
              Text(specString("Pie chart with legend. Toggle Values to show amounts inside segments."))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if vm.isDonut as? Bool ?? false {
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              Text(specString("Task Status Distribution"))
                .font(.headline.bold())
                .foregroundStyle(.primary)
              ChartView(colors: ["#10b981", "#6366f1", "#f59e0b", "#ef4444", "#6b7280"] as [Any], data: [["status": "Done" as Any, "count": 142 as Any] as [String: Any], ["status": "In Progress" as Any, "count": 38 as Any] as [String: Any], ["status": "Review" as Any, "count": 24 as Any] as [String: Any], ["status": "Blocked" as Any, "count": 11 as Any] as [String: Any], ["status": "Todo" as Any, "count": 67 as Any] as [String: Any]] as [Any], height: "320px", labelKey: "status", showLegend: true, showValues: true, type: "donut", valueKey: "count")
              Text(specString("Donut chart — total shown in center ring. Good for part-to-whole relationships."))
                .font(.callout.bold())
                .foregroundStyle(.secondary)
            }
            .padding(CGFloat(20))
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

    }
    .foregroundStyle(.primary)
  }
}
