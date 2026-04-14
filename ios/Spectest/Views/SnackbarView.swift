import SwiftUI
import SpecRuntime

@Observable
final class SnackbarViewModel {
  var actionLabel: Any = ""
  var duration: Any = 4000
  var message: Any = ""
  var open: Any = false
  var showing: Any = false
  func doOpen() {
    showing = true
    // unsupported: delay
  }
  func doClose() {
    showing = false
    /* event callback */
  }
  func doAction() {
    /* event callback */
    doClose()
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct SnackbarView: View {
  @State private var vm = SnackbarViewModel()
  var actionLabel: Any = ""
  var duration: Any = 4000
  var message: Any = ""
  var open: Any = false
  init(actionLabel: Any = "", duration: Any = 4000, message: Any = "", open: Any = false) { self._vm = State(initialValue: SnackbarViewModel()); self.actionLabel = actionLabel; self.duration = duration; self.message = message; self.open = open }
  var body: some View {
    VStack() {
      VStack() {
        if specEq(vm.showing, true) {
          HStack(alignment: .center, spacing: CGFloat(12)) {
            Text(verbatim: specString(vm.message))
              .font(.callout.bold())
              .foregroundStyle(Color.white)
            Button(action: { vm.doAction() }) {
            VStack() {
              if specNeq(vm.actionLabel, "") {
                Text(verbatim: specString(vm.actionLabel))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
              }
            }

            }
            .buttonStyle(.plain)
            Button(action: { vm.doClose() }) {
            HStack(alignment: .center, ) {
              Text(verbatim: specString("u00D7"))
                .foregroundStyle(Color(.sRGB, red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.7))
            }
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            .frame(width: CGFloat(24))
            .specFrameHeight(CGFloat(24))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }
          .padding(.leading, CGFloat(16))
          .padding(.trailing, CGFloat(16))
          .padding(.top, CGFloat(12))
          .padding(.bottom, CGFloat(12))
          .frame(maxWidth: CGFloat(560))
          .background(Color(.sRGB, red: 0.1176, green: 0.1176, blue: 0.1176), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
      }
      .padding(.bottom, CGFloat(0))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.duration, duration) { vm.duration = duration }; if !specEq(vm.actionLabel, actionLabel) { vm.actionLabel = actionLabel } }
    .task(id: specPropsKey([open, message, duration, actionLabel])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.duration, duration) { vm.duration = duration }; if !specEq(vm.actionLabel, actionLabel) { vm.actionLabel = actionLabel } }
  }
}
