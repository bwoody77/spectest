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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
      VStack(spacing: CGFloat(8)) {
        HStack(alignment: .center) {
          if specNeq(vm.title, "") {
            Text(verbatim: specString(vm.title))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          }
        }
        .padding(.bottom, CGFloat(4))
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
              .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
          }
        }
        .frame(maxWidth: .infinity)
        HStack(alignment: .center, spacing: CGFloat(12)) {
          if (vm.showLegendBar) as? Bool ?? false {
            ForEach(Array(specArr(vm.legendItems).enumerated()), id: \.offset) { _idx, item in
              HStack(alignment: .center, spacing: CGFloat(4)) {
                VStack() {
                }
                .frame(width: CGFloat(10))
                .specFrameHeight(CGFloat(10))
                .background(Color(hex: specGet(item, "color") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                Text(verbatim: specString(specGet(item, "label")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }

            }
          }
        }

      }
      .frame(maxWidth: .infinity)
      .specFrameHeight(specPx(vm.height))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.data, data) { vm.data = data }; if !specEq(vm.series, series) { vm.series = series }; if !specEq(vm.xKey, xKey) { vm.xKey = xKey }; if !specEq(vm.yKey, yKey) { vm.yKey = yKey }; if !specEq(vm.labelKey, labelKey) { vm.labelKey = labelKey }; if !specEq(vm.valueKey, valueKey) { vm.valueKey = valueKey }; if !specEq(vm.color, color) { vm.color = color }; if !specEq(vm.colors, colors) { vm.colors = colors }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.showLegend, showLegend) { vm.showLegend = showLegend }; if !specEq(vm.showGrid, showGrid) { vm.showGrid = showGrid }; if !specEq(vm.showValues, showValues) { vm.showValues = showValues }; if !specEq(vm.yMin, yMin) { vm.yMin = yMin }; if !specEq(vm.yMax, yMax) { vm.yMax = yMax }; if !specEq(vm.connectNulls, connectNulls) { vm.connectNulls = connectNulls }; if !specEq(vm.colorKey, colorKey) { vm.colorKey = colorKey }; if !specEq(vm.formatX, formatX) { vm.formatX = formatX }; if !specEq(vm.formatY, formatY) { vm.formatY = formatY } }
    .task(id: specPropsKey([type, data, series, xKey, yKey, labelKey, valueKey, color, colors, height, title, showLegend, showGrid, showValues, yMin, yMax, connectNulls, colorKey, formatX, formatY])) { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.data, data) { vm.data = data }; if !specEq(vm.series, series) { vm.series = series }; if !specEq(vm.xKey, xKey) { vm.xKey = xKey }; if !specEq(vm.yKey, yKey) { vm.yKey = yKey }; if !specEq(vm.labelKey, labelKey) { vm.labelKey = labelKey }; if !specEq(vm.valueKey, valueKey) { vm.valueKey = valueKey }; if !specEq(vm.color, color) { vm.color = color }; if !specEq(vm.colors, colors) { vm.colors = colors }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.showLegend, showLegend) { vm.showLegend = showLegend }; if !specEq(vm.showGrid, showGrid) { vm.showGrid = showGrid }; if !specEq(vm.showValues, showValues) { vm.showValues = showValues }; if !specEq(vm.yMin, yMin) { vm.yMin = yMin }; if !specEq(vm.yMax, yMax) { vm.yMax = yMax }; if !specEq(vm.connectNulls, connectNulls) { vm.connectNulls = connectNulls }; if !specEq(vm.colorKey, colorKey) { vm.colorKey = colorKey }; if !specEq(vm.formatX, formatX) { vm.formatX = formatX }; if !specEq(vm.formatY, formatY) { vm.formatY = formatY } }
  }
}
