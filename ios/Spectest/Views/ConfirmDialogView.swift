import SwiftUI
import SpecRuntime

@Observable
final class ConfirmDialogViewModel {
  var cancelLabel: Any = "Cancel"
  var confirmLabel: Any = "Confirm"
  var destructive: Any = false
  var message: Any = ""
  var open: Any = false
  var title: Any = "Confirm"
  var showing: Any = false
  func doOpen() {
    if (showing) as? Bool ?? false {
      return
    }
    showing = true
    // unsupported: builtin-call
    // unsupported: builtin-call
  }
  func doClose() {
    if ((!((showing) as? Bool ?? false))) as? Bool ?? false {
      return
    }
    showing = false
    // unsupported: builtin-call
    // unsupported: builtin-call
  }
  func confirm() {
    /* event callback */
    doClose()
  }
  func cancel() {
    /* event callback */
    doClose()
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct ConfirmDialogView: View {
  @State private var vm = ConfirmDialogViewModel()
  var cancelLabel: Any = "Cancel"
  var confirmLabel: Any = "Confirm"
  var destructive: Any = false
  var message: Any = ""
  var open: Any = false
  var title: Any = "Confirm"
  init(cancelLabel: Any = "Cancel", confirmLabel: Any = "Confirm", destructive: Any = false, message: Any = "", open: Any = false, title: Any = "Confirm") { self._vm = State(initialValue: ConfirmDialogViewModel()); self.cancelLabel = cancelLabel; self.confirmLabel = confirmLabel; self.destructive = destructive; self.message = message; self.open = open; self.title = title }
  var body: some View {
    VStack() {
      Color.clear.frame(width: 0, height: 0)
        .overlay {
          if (vm.showing) as? Bool ?? false {
            ZStack {
              Color.black.opacity(0.15).ignoresSafeArea()
                .onTapGesture {
                  vm.cancel()
                }
              VStack(spacing: CGFloat(12)) {
                Text(verbatim: specString(vm.title))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                Text(verbatim: specString(vm.message))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Button(action: { Task { @MainActor in await vm.cancel() } }) {
                    Text(specString(vm.cancelLabel))
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(.blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                  }
                  VStack() {
                    if specEq(vm.destructive, false) {
                      Button(action: { Task { @MainActor in await vm.confirm() } }) {
                        Text(specString(vm.confirmLabel))
                          .font(.subheadline.weight(.semibold))
                          .foregroundStyle(.white)
                          .padding(.horizontal, 16)
                          .padding(.vertical, 8)
                          .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                      }
                    }
                  }

                  VStack() {
                    if specEq(vm.destructive, true) {
                      Button(action: { Task { @MainActor in await vm.confirm() } }) {
                        Text(specString(vm.confirmLabel))
                          .font(.subheadline.weight(.semibold))
                          .foregroundStyle(specString("destructive") == "primary" ? .white : .blue)
                          .padding(.horizontal, 16)
                          .padding(.vertical, 8)
                          .background(specString("destructive") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
                      }
                    }
                  }

                }

              }
              .padding(CGFloat(20))
              .frame(width: CGFloat(440))
              .frame(maxWidth: CGFloat(0))
              .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.confirmLabel, confirmLabel) { vm.confirmLabel = confirmLabel }; if !specEq(vm.cancelLabel, cancelLabel) { vm.cancelLabel = cancelLabel }; if !specEq(vm.destructive, destructive) { vm.destructive = destructive } }
    .task(id: specPropsKey([open, title, message, confirmLabel, cancelLabel, destructive])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.confirmLabel, confirmLabel) { vm.confirmLabel = confirmLabel }; if !specEq(vm.cancelLabel, cancelLabel) { vm.cancelLabel = cancelLabel }; if !specEq(vm.destructive, destructive) { vm.destructive = destructive } }
  }
}
