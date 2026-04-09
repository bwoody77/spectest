import SwiftUI
import SpecRuntime
@Observable final class DatePickerViewModel {}
struct DatePickerView: View { @State private var vm = DatePickerViewModel(); var format: Any = ""; var label: Any = ""; var placeholder: Any = ""; var value: Any = ""; init(format: Any = "", label: Any = "", placeholder: Any = "", value: Any = "") { self._vm = State(initialValue: DatePickerViewModel()); self.format = format; self.label = label; self.placeholder = placeholder; self.value = value }; var body: some View { SwiftUI.DatePicker(specString(label), selection: .constant(Date())).datePickerStyle(.compact) } }
