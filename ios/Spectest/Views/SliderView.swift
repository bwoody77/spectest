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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
          Text(verbatim: specString("\(specString(vm.displayValue))"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        }

        HStack(alignment: .center, ) {
          if specEq(vm.label, "") {
            Text(verbatim: specString("\(specString(vm.displayValue))"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          }
        }

        TextField("", text: Binding(get: { vm.currentValue as? String ?? "" }, set: { vm.currentValue = $0 }))
          .textFieldStyle(.roundedBorder)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.min, min) { vm.min = min }; if !specEq(vm.max, max) { vm.max = max }; if !specEq(vm.step, step) { vm.step = step }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([min, max, step, value, label, disabled])) { if !specEq(vm.min, min) { vm.min = min }; if !specEq(vm.max, max) { vm.max = max }; if !specEq(vm.step, step) { vm.step = step }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
