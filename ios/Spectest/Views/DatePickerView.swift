// @speckeep — DatePicker component uses native SwiftUI DatePicker via emitComponent handler
import SwiftUI
import SpecRuntime
@Observable final class DatePickerViewModel {}
struct DatePickerView: View {
  @State private var vm = DatePickerViewModel()
  var disabled: Any = false; var format: Any = ""; var label: Any = ""; var placeholder: Any = ""; var value: Any = ""
  init(disabled: Any = false, format: Any = "", label: Any = "", placeholder: Any = "", value: Any = "") {
    self._vm = State(initialValue: DatePickerViewModel()); self.disabled = disabled; self.format = format; self.label = label; self.placeholder = placeholder; self.value = value
  }
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      if !specString(label).isEmpty { Text(specString(label)).font(.subheadline).foregroundStyle(.secondary) }
      SwiftUI.DatePicker("", selection: .constant(Date()), displayedComponents: .date)
        .datePickerStyle(.compact).labelsHidden().disabled(disabled as? Bool ?? false)
    }
  }
}
