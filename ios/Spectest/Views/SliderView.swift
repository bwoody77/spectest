import SwiftUI
import SpecRuntime

@Observable
final class SliderViewModel {
  var disabled: Any = false
  var label: Any = ""
  var max: Any = 100
  var min: Any = 0
  var step: Any = 1
  var value: Any = 50
  var currentValue: Any = 50
  var displayValue: Any { currentValue }
  func updateValue(_ v: Any) {
    currentValue = v
    /* event callback */
  }
}

struct SliderView: View {
  @State private var vm = SliderViewModel()
  var disabled: Any = false
  var label: Any = ""
  var max: Any = 100
  var min: Any = 0
  var step: Any = 1
  var value: Any = 50
  init(disabled: Any = false, label: Any = "", max: Any = 100, min: Any = 0, step: Any = 1, value: Any = 50) { self._vm = State(initialValue: SliderViewModel()); self.disabled = disabled; self.label = label; self.max = max; self.min = min; self.step = step; self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(8)) {
        HStack(alignment: .center, ) {
          if (specString(vm.label) != specString("")) {
            Text(specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(.secondary)
          }
          Text(specString("\(specString(vm.displayValue))"))
            .font(.body.bold())
            .foregroundStyle(.primary)
        }

        HStack(alignment: .center, ) {
          if (specString(vm.label) == specString("")) {
            Text(specString("\(specString(vm.displayValue))"))
              .font(.body.bold())
              .foregroundStyle(.primary)
          }
        }

        TextField("", text: Binding(get: { vm.currentValue as? String ?? "" }, set: { vm.currentValue = $0 }))
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.min = min; vm.max = max; vm.step = step; vm.value = value; vm.label = label; vm.disabled = disabled }
  }
}
