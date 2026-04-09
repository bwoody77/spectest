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
    showing = true
    // unsupported: builtin-call
    // unsupported: builtin-call
  }
  func doClose() {
    showing = false
    // unsupported: builtin-call
    // unsupported: builtin-call
  }
  func confirm() {
    doClose()
    /* event callback */
  }
  func cancel() {
    doClose()
    /* event callback */
  }
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
      VStack() {
        VStack() {
          if (specString(vm.showing) == specString(true)) {
          }
        }
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.5))
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.5))
        VStack(spacing: CGFloat(12)) {
          if (specString(vm.showing) == specString(true)) {
            Text(specString(vm.title))
              .font(.headline.bold())
              .foregroundStyle(.primary)
          }
          Text(specString(vm.message))
            .font(.body.bold())
            .foregroundStyle(.secondary)
          HStack(alignment: .center, spacing: CGFloat(8)) {
            Button(action: { Task { await vm.cancel() } }) {
              Text(specString(vm.cancelLabel))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
            }
            VStack() {
              if (specString(vm.destructive) == specString(false)) {
                Button(action: { Task { await vm.confirm() } }) {
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
              if (specString(vm.destructive) == specString(true)) {
                Button(action: { Task { await vm.confirm() } }) {
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
        .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(12)))
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.open = open; vm.title = title; vm.message = message; vm.confirmLabel = confirmLabel; vm.cancelLabel = cancelLabel; vm.destructive = destructive }
  }
}
