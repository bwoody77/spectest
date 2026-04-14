import SwiftUI
import SpecRuntime

@Observable
final class ChartViewModel {
  var color: Any = ""
  var colorKey: Any = ""
  var colors: Any = [] as [Any]
  var connectNulls: Any = false
  var data: Any = [] as [Any]
  var formatX: Any = ""
  var formatY: Any = ""
  var height: Any = "300px"
  var labelKey: Any = "label"
  var series: Any = [] as [Any]
  var showGrid: Any = true
  var showLegend: Any = true
  var showValues: Any = false
  var title: Any = ""
  var type: Any = "line"
  var valueKey: Any = "value"
  var xKey: Any = "x"
  var yKey: Any = "y"
  var yMax: Any? = nil
  var yMin: Any? = nil
  var isEmpty: Any { (data == nil || specEq(specLength(data), 0)) }
  var isPie: Any { (specEq(type, "pie") || specEq(type, "donut")) }
  var resolvedSeries: Any { resolveSeries(type, series, yKey, color, colors) }
  var legendItems: Any { ((isPie) as? Bool ?? false ? resolveSegmentMeta(data, colors, labelKey) : resolvedSeries) }
  var showLegendBar: Any { ((showLegend) as? Bool ?? false && ((isPie) as? Bool ?? false || (specDouble(specLength(resolvedSeries)) > specDouble(1)))) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ChartView: View {
  @State private var vm = ChartViewModel()
  var color: Any = ""
  var colorKey: Any = ""
  var colors: Any = [] as [Any]
  var connectNulls: Any = false
  var data: Any = [] as [Any]
  var formatX: Any = ""
  var formatY: Any = ""
  var height: Any = "300px"
  var labelKey: Any = "label"
  var series: Any = [] as [Any]
  var showGrid: Any = true
  var showLegend: Any = true
  var showValues: Any = false
  var title: Any = ""
  var type: Any = "line"
  var valueKey: Any = "value"
  var xKey: Any = "x"
  var yKey: Any = "y"
  var yMax: Any? = nil
  var yMin: Any? = nil
  init(color: Any = "", colorKey: Any = "", colors: Any = [] as [Any], connectNulls: Any = false, data: Any = [] as [Any], formatX: Any = "", formatY: Any = "", height: Any = "300px", labelKey: Any = "label", series: Any = [] as [Any], showGrid: Any = true, showLegend: Any = true, showValues: Any = false, title: Any = "", type: Any = "line", valueKey: Any = "value", xKey: Any = "x", yKey: Any = "y", yMax: Any? = nil, yMin: Any? = nil) { self._vm = State(initialValue: ChartViewModel()); self.color = color; self.colorKey = colorKey; self.colors = colors; self.connectNulls = connectNulls; self.data = data; self.formatX = formatX; self.formatY = formatY; self.height = height; self.labelKey = labelKey; self.series = series; self.showGrid = showGrid; self.showLegend = showLegend; self.showValues = showValues; self.title = title; self.type = type; self.valueKey = valueKey; self.xKey = xKey; self.yKey = yKey; self.yMax = yMax; self.yMin = yMin }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
        HStack(alignment: .center) {
          if specNeq(vm.title, "") {
            Text(verbatim: specString(vm.title))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
          }
        }
        .padding(.bottom, ThemeManager.shared.size("spacing-1"))
        VStack() {
          if specEq(vm.isEmpty, false) {
            // mount: ChartSVG
          }
        }
        .frame(maxWidth: .infinity)
        HStack(alignment: .center) {
          if (vm.isEmpty) as? Bool ?? false {
            Text(verbatim: specString("No data"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
          }
        }
        .frame(maxWidth: .infinity)
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          if (vm.showLegendBar) as? Bool ?? false {
            ForEach(Array(specArr(vm.legendItems).enumerated()), id: \.offset) { _idx, item in
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
                VStack() {
                }
                .frame(width: CGFloat(10))
                .specFrameHeight(CGFloat(10))
                .background(Color(hex: specGet(item, "color") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                Text(verbatim: specString(specGet(item, "label")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }

            }
          }
        }

      }
      .frame(maxWidth: .infinity)
      .specFrameHeight(specPx(vm.height))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.data, data) { vm.data = data }; if !specEq(vm.series, series) { vm.series = series }; if !specEq(vm.xKey, xKey) { vm.xKey = xKey }; if !specEq(vm.yKey, yKey) { vm.yKey = yKey }; if !specEq(vm.labelKey, labelKey) { vm.labelKey = labelKey }; if !specEq(vm.valueKey, valueKey) { vm.valueKey = valueKey }; if !specEq(vm.color, color) { vm.color = color }; if !specEq(vm.colors, colors) { vm.colors = colors }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.showLegend, showLegend) { vm.showLegend = showLegend }; if !specEq(vm.showGrid, showGrid) { vm.showGrid = showGrid }; if !specEq(vm.showValues, showValues) { vm.showValues = showValues }; if !specEq(vm.yMin, yMin) { vm.yMin = yMin }; if !specEq(vm.yMax, yMax) { vm.yMax = yMax }; if !specEq(vm.connectNulls, connectNulls) { vm.connectNulls = connectNulls }; if !specEq(vm.colorKey, colorKey) { vm.colorKey = colorKey }; if !specEq(vm.formatX, formatX) { vm.formatX = formatX }; if !specEq(vm.formatY, formatY) { vm.formatY = formatY } }
    .task(id: specPropsKey([type, data, series, xKey, yKey, labelKey, valueKey, color, colors, height, title, showLegend, showGrid, showValues, yMin, yMax, connectNulls, colorKey, formatX, formatY])) { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.data, data) { vm.data = data }; if !specEq(vm.series, series) { vm.series = series }; if !specEq(vm.xKey, xKey) { vm.xKey = xKey }; if !specEq(vm.yKey, yKey) { vm.yKey = yKey }; if !specEq(vm.labelKey, labelKey) { vm.labelKey = labelKey }; if !specEq(vm.valueKey, valueKey) { vm.valueKey = valueKey }; if !specEq(vm.color, color) { vm.color = color }; if !specEq(vm.colors, colors) { vm.colors = colors }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.showLegend, showLegend) { vm.showLegend = showLegend }; if !specEq(vm.showGrid, showGrid) { vm.showGrid = showGrid }; if !specEq(vm.showValues, showValues) { vm.showValues = showValues }; if !specEq(vm.yMin, yMin) { vm.yMin = yMin }; if !specEq(vm.yMax, yMax) { vm.yMax = yMax }; if !specEq(vm.connectNulls, connectNulls) { vm.connectNulls = connectNulls }; if !specEq(vm.colorKey, colorKey) { vm.colorKey = colorKey }; if !specEq(vm.formatX, formatX) { vm.formatX = formatX }; if !specEq(vm.formatY, formatY) { vm.formatY = formatY } }
  }
}
