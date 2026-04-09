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
        ForEach(Array((vm.options as? [Any] ?? []).enumerated()), id: \.offset) { _idx, option in
          Picker(specString((option as? [String: Any])?["label"]), selection: .constant("")) {
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
    .onAppear { vm.options = options; vm.value = value; vm.disabled = disabled }
  }
}
