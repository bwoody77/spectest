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
        if (specString(vm.showing) == specString(true)) {
          HStack(alignment: .center, spacing: CGFloat(12)) {
            Text(specString(vm.message))
              .font(.callout.bold())
              .foregroundStyle(Color.white)
            VStack() {
              if (specString(vm.actionLabel) != specString("")) {
                Text(specString(vm.actionLabel))
                  .font(.body.bold())
                  .foregroundStyle(Color.blue)
              }
            }

            .onTapGesture { vm.doAction() }
            HStack(alignment: .center, ) {
              Text(specString("u00D7"))
                .foregroundStyle(Color(.sRGB, red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.7))
            }
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(12)))
            .frame(width: CGFloat(24))
            .frame(height: CGFloat(24))
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(12)))
            .onTapGesture { vm.doClose() }
          }
          .padding(.leading, CGFloat(16))
          .padding(.trailing, CGFloat(16))
          .padding(.top, CGFloat(12))
          .padding(.bottom, CGFloat(12))
          .frame(maxWidth: CGFloat(560))
          .background(Color(.sRGB, red: 0.1176, green: 0.1176, blue: 0.1176), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        }
      }
      .padding(.bottom, CGFloat(0))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.open = open; vm.message = message; vm.duration = duration; vm.actionLabel = actionLabel }
  }
}
