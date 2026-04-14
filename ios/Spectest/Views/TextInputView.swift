import SwiftUI
import SpecRuntime

@Observable
final class TextInputViewModel {
  var disabled: Any = false
  var error: Any = false
  var errorMessage: Any = ""
  var label: Any = ""
  var placeholder: Any = ""
  var prefix: Any = ""
  var readonly: Any = false
  var suffix: Any = ""
  var type: Any = "text"
  var value: Any = ""
  var focused: Any = false
  func handleFocus() {
    focused = true
  }
  func handleBlur() {
    focused = false
    /* event callback */
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TextInputView: View {
  @State private var vm = TextInputViewModel()
  var disabled: Any = false
  var error: Any = false
  var errorMessage: Any = ""
  var label: Any = ""
  var placeholder: Any = ""
  var prefix: Any = ""
  var readonly: Any = false
  var suffix: Any = ""
  var type: Any = "text"
  var value: Any = ""
  init(disabled: Any = false, error: Any = false, errorMessage: Any = "", label: Any = "", placeholder: Any = "", prefix: Any = "", readonly: Any = false, suffix: Any = "", type: Any = "text", value: Any = "") { self._vm = State(initialValue: TextInputViewModel()); self.disabled = disabled; self.error = error; self.errorMessage = errorMessage; self.label = label; self.placeholder = placeholder; self.prefix = prefix; self.readonly = readonly; self.suffix = suffix; self.type = type; self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(6)) {
        VStack() {
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
        }

        HStack(alignment: .center, spacing: CGFloat(8)) {
          VStack() {
            if specNeq(vm.prefix, "") {
              Text(verbatim: specString(vm.prefix))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }

          VStack() {
            if specNeq(vm.type, "textarea") {
              TextField("", text: Binding(get: { vm.value as? String ?? "" }, set: { vm.value = $0 }))
            }
          }
          .frame(maxWidth: .infinity)
          VStack() {
            if specEq(vm.type, "textarea") {
              TextEditor(text: Binding(get: { vm.value as? String ?? "" }, set: { vm.value = $0 }))
            }
          }
          .frame(maxWidth: .infinity)
          VStack() {
            if specNeq(vm.suffix, "") {
              Text(verbatim: specString(vm.suffix))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }

        }
        .padding(CGFloat(8))
        .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        VStack() {
          if specEq(vm.error, true) {
            Text(verbatim: specString(vm.errorMessage))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.destructive"))
          }
        }

      }
      .opacity(specPx(({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.readonly, readonly) { vm.readonly = readonly }; if !specEq(vm.prefix, prefix) { vm.prefix = prefix }; if !specEq(vm.suffix, suffix) { vm.suffix = suffix }; if !specEq(vm.error, error) { vm.error = error }; if !specEq(vm.errorMessage, errorMessage) { vm.errorMessage = errorMessage } }
    .task(id: specPropsKey([type, label, placeholder, value, disabled, readonly, prefix, suffix, error, errorMessage])) { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.readonly, readonly) { vm.readonly = readonly }; if !specEq(vm.prefix, prefix) { vm.prefix = prefix }; if !specEq(vm.suffix, suffix) { vm.suffix = suffix }; if !specEq(vm.error, error) { vm.error = error }; if !specEq(vm.errorMessage, errorMessage) { vm.errorMessage = errorMessage } }
  }
}
