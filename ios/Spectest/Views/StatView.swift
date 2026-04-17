import SwiftUI
import SpecRuntime

@Observable
final class StatViewModel {
  var helpText: Any = ""
  var label: Any? = nil
  var trend: Any = ""
  var trendValue: Any = ""
  var value: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct StatView: View {
  @State private var vm = StatViewModel()
  var helpText: Any = ""
  var label: Any? = nil
  var trend: Any = ""
  var trendValue: Any = ""
  var value: Any? = nil
  init(helpText: Any = "", label: Any? = nil, trend: Any = "", trendValue: Any = "", value: Any? = nil) { self._vm = State(initialValue: StatViewModel()); self.helpText = helpText; self.label = label; self.trend = trend; self.trendValue = trendValue; self.value = value }
  var body: some View {
    VStack() {
      VStack() {
        Text(verbatim: specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        Text(verbatim: specString(vm.value))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        HStack(alignment: .center, spacing: CGFloat(4)) {
          if specNeq(vm.trend, "") {
            Text(verbatim: specString(({ () -> Any in switch specString(vm.trend) {
case specString("up"): return "↑"
case specString("down"): return "↓"
default: return "→"
} })()))
              .font(.body.bold())
              .foregroundStyle(({ () -> Color in switch specString(vm.trend) {
case specString("up"): return Color(hex: "#22c55e")
case specString("down"): return Color(hex: "#ef4444")
default: return ThemeManager.shared.color("text-tertiary")
} })())
          }
          Text(verbatim: specString(vm.trendValue))
            .font(.body.bold())
            .foregroundStyle(({ () -> Color in switch specString(vm.trend) {
case specString("up"): return Color(hex: "#22c55e")
case specString("down"): return Color(hex: "#ef4444")
default: return ThemeManager.shared.color("text-tertiary")
} })())
        }

        Text(verbatim: specString(vm.helpText))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.trend, trend) { vm.trend = trend }; if !specEq(vm.trendValue, trendValue) { vm.trendValue = trendValue }; if !specEq(vm.helpText, helpText) { vm.helpText = helpText } }
    .task(id: specPropsKey([label, value, trend, trendValue, helpText])) { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.trend, trend) { vm.trend = trend }; if !specEq(vm.trendValue, trendValue) { vm.trendValue = trendValue }; if !specEq(vm.helpText, helpText) { vm.helpText = helpText } }
  }
}
