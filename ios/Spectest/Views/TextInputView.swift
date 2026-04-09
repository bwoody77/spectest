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
          if (specString(vm.label) != specString("")) {
            Text(specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
        }

        HStack(alignment: .center, spacing: CGFloat(8)) {
          VStack() {
            if (specString(vm.prefix) != specString("")) {
              Text(specString(vm.prefix))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }

          VStack() {
            if (specString(vm.type) != specString("textarea")) {
              TextField("", text: Binding(get: { vm.value as? String ?? "" }, set: { vm.value = $0 }))
            }
          }
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
          VStack() {
            if (specString(vm.type) == specString("textarea")) {
              TextEditor(text: Binding(get: { vm.value as? String ?? "" }, set: { vm.value = $0 }))
            }
          }
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
          VStack() {
            if (specString(vm.suffix) != specString("")) {
              Text(specString(vm.suffix))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }

        }
        .padding(CGFloat(8))
        .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        VStack() {
          if (specString(vm.error) == specString(true)) {
            Text(specString(vm.errorMessage))
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
    .onAppear { vm.type = type; vm.label = label; vm.placeholder = placeholder; vm.value = value; vm.disabled = disabled; vm.readonly = readonly; vm.prefix = prefix; vm.suffix = suffix; vm.error = error; vm.errorMessage = errorMessage }
  }
}
