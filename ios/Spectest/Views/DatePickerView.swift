// @speckeep
import SwiftUI
import SpecRuntime
@Observable final class DatePickerViewModel {}
struct DatePickerView: View { @State private var vm = DatePickerViewModel(); var disabled: Any = false; var format: Any = ""; var label: Any = ""; var placeholder: Any = ""; var value: Any = ""; init(disabled: Any = false, format: Any = "", label: Any = "", placeholder: Any = "", value: Any = "") { self._vm = State(initialValue: DatePickerViewModel()); self.disabled = disabled; self.format = format; self.label = label; self.placeholder = placeholder; self.value = value }; var body: some View { SwiftUI.DatePicker(specString(label), selection: .constant(Date())).datePickerStyle(.compact).disabled(disabled as? Bool ?? false) } }
