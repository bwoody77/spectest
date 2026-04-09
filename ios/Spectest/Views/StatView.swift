import SwiftUI
import SpecRuntime

@Observable
final class StatViewModel {
  var helpText: Any = ""
  var label: Any? = nil
  var trend: Any = ""
  var trendValue: Any = ""
  var value: Any? = nil
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
        Text(specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        Text(specString(vm.value))
          .font(.body.bold())
          .foregroundStyle(.primary)
        HStack(alignment: .center, spacing: CGFloat(4)) {
          if (specString(vm.trend) != specString("")) {
            Text(specString(({ () -> Any in switch specString(vm.trend) {
case specString("up"): return "↑"
case specString("down"): return "↓"
default: return "→"
} })()))
              .font(.body.bold())
              .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.trend) {
case specString("up"): return "#22c55e"
case specString("down"): return "#ef4444"
default: return "#92a2b9"
} })() as? String ?? "#000"))
          }
          Text(specString(vm.trendValue))
            .font(.body.bold())
            .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.trend) {
case specString("up"): return "#22c55e"
case specString("down"): return "#ef4444"
default: return "#92a2b9"
} })() as? String ?? "#000"))
        }

        Text(specString(vm.helpText))
          .font(.body.bold())
          .foregroundStyle(.tertiary)
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.label = label; vm.value = value; vm.trend = trend; vm.trendValue = trendValue; vm.helpText = helpText }
  }
}
