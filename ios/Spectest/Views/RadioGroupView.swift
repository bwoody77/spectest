import SwiftUI
import SpecRuntime

@Observable
final class RadioGroupViewModel {
  var disabled: Any = false
  var options: Any = [] as [Any]
  var value: Any = ""
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct RadioGroupView: View {
  @State private var vm = RadioGroupViewModel()
  var disabled: Any = false
  var options: Any = [] as [Any]
  var value: Any = ""
  init(disabled: Any = false, options: Any = [] as [Any], value: Any = "") { self._vm = State(initialValue: RadioGroupViewModel()); self.disabled = disabled; self.options = options; self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(8)) {
        ForEach(Array(specArr(vm.options).enumerated()), id: \.offset) { _idx, option in
          Picker(specString(specGet(option, "label")), selection: .constant("")) {
            ForEach(Array(([] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
              Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
            }
          }
          .pickerStyle(.segmented)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([options, value, disabled])) { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
