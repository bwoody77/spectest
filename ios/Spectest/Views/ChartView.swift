import SwiftUI
import SpecRuntime

@Observable
final class ChartViewModel {
  var color: Any = ""
  var colors: Any = [] as [Any]
  var data: Any = [] as [Any]
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
  var isEmpty: Any { (data == nil || (specString(specLength(data)) == specString(0))) }
  var isPie: Any { ((specString(type) == specString("pie")) || (specString(type) == specString("donut"))) }
  var resolvedSeries: Any { resolveSeries(type, series, yKey, color, colors) }
  var legendItems: Any { ((isPie) as? Bool ?? false ? resolveSegmentMeta(data, colors, labelKey) : resolvedSeries) }
  var showLegendBar: Any { (showLegend as? Bool ?? false && (isPie as? Bool ?? false || ((specLength(resolvedSeries) as? Double ?? 0) > (1 as? Double ?? 0)))) }
}

struct ChartView: View {
  @State private var vm = ChartViewModel()
  var color: Any = ""
  var colors: Any = [] as [Any]
  var data: Any = [] as [Any]
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
  init(color: Any = "", colors: Any = [] as [Any], data: Any = [] as [Any], height: Any = "300px", labelKey: Any = "label", series: Any = [] as [Any], showGrid: Any = true, showLegend: Any = true, showValues: Any = false, title: Any = "", type: Any = "line", valueKey: Any = "value", xKey: Any = "x", yKey: Any = "y") { self._vm = State(initialValue: ChartViewModel()); self.color = color; self.colors = colors; self.data = data; self.height = height; self.labelKey = labelKey; self.series = series; self.showGrid = showGrid; self.showLegend = showLegend; self.showValues = showValues; self.title = title; self.type = type; self.valueKey = valueKey; self.xKey = xKey; self.yKey = yKey }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(8)) {
        HStack(alignment: .center, ) {
          if (specString(vm.title) != specString("")) {
            Text(specString(vm.title))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          }
        }
        .padding(.bottom, CGFloat(4))
        VStack() {
          if (specString(vm.isEmpty) == specString(false)) {
            // mount: ChartSVG
          }
        }
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
        HStack(alignment: .center, ) {
          if vm.isEmpty as? Bool ?? false {
            Text(specString("No data"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
          }
        }
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
        HStack(alignment: .center, spacing: CGFloat(12)) {
          if vm.showLegendBar as? Bool ?? false {
            ForEach(Array((vm.legendItems as? [Any] ?? []).enumerated()), id: \.offset) { _idx, item in
              HStack(alignment: .center, spacing: CGFloat(4)) {
                VStack() {
                }
                .frame(width: CGFloat(10))
                .frame(height: CGFloat(10))
                .background(Color(hex: (item as? [String: Any])?["color"] as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                Text(specString((item as? [String: Any])?["label"]))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }

            }
          }
        }

      }
      .frame(width: CGFloat(0))
      .frame(height: specPx(vm.height))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.type = type; vm.data = data; vm.series = series; vm.xKey = xKey; vm.yKey = yKey; vm.labelKey = labelKey; vm.valueKey = valueKey; vm.color = color; vm.colors = colors; vm.height = height; vm.title = title; vm.showLegend = showLegend; vm.showGrid = showGrid; vm.showValues = showValues }
  }
}
