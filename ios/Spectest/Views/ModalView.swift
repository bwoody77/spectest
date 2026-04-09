import SwiftUI
import SpecRuntime

@Observable
final class ModalViewModel {
  var open: Any = false
  var title: Any = ""
  var width: Any = "500px"
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
    /* event callback */
  }
}

struct ModalView: View {
  @State private var vm = ModalViewModel()
  var open: Any = false
  var title: Any = ""
  var width: Any = "500px"
  init(open: Any = false, title: Any = "", width: Any = "500px") { self._vm = State(initialValue: ModalViewModel()); self.open = open; self.title = title; self.width = width }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
          if (specString(vm.showing) == specString(true)) {
          }
        }
        .background(Color(.sRGB, red: 0.0588, green: 0.0902, blue: 0.1647, opacity: 0.5))
        .background(Color(.sRGB, red: 0.0588, green: 0.0902, blue: 0.1647, opacity: 0.5))
        .onTapGesture { vm.doClose() }
        VStack() {
          if (specString(vm.showing) == specString(true)) {
            HStack(alignment: .center, ) {
              Text(specString(vm.title))
                .font(.headline.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              HStack(alignment: .center, ) {
                Text(specString("u00D7"))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              }
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .frame(width: CGFloat(32))
              .frame(height: CGFloat(32))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .onTapGesture { vm.doClose() }
            }
            .padding(CGFloat(16))
          }
          VStack() {
            // slot
          }
          .padding(CGFloat(20))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
          .scrollIndicators(.visible)
        }
        .frame(width: specPx(vm.width))
        .frame(maxWidth: CGFloat(0))
        .frame(maxHeight: CGFloat(0))
        .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
        .scrollIndicators(.visible)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.open = open; vm.title = title; vm.width = width }
  }
}
