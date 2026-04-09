import SwiftUI
import SpecRuntime

@Observable
final class DrawerViewModel {
  var open: Any = false
  var side: Any = "left"
  var title: Any = ""
  var width: Any = "280px"
  var showing: Any = false
  var panelTransform: Any { ({ () -> Any in switch specString(showing) {
case specString(true): return "translateX(0)"
default: return ({ () -> Any in switch specString(side) {
case specString("right"): return "translateX(100%)"
default: return "translateX(-100%)"
} })()
} })() }
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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct DrawerView: View {
  @State private var vm = DrawerViewModel()
  var open: Any = false
  var side: Any = "left"
  var title: Any = ""
  var width: Any = "280px"
  init(open: Any = false, side: Any = "left", title: Any = "", width: Any = "280px") { self._vm = State(initialValue: DrawerViewModel()); self.open = open; self.side = side; self.title = title; self.width = width }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
          if (specString(vm.showing) == specString(true)) {
          }
        }
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.4))
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.4))
        .onTapGesture { vm.doClose() }
        VStack() {
          if ((specString(vm.showing) == specString(true)) && (specString(vm.side) == specString("left"))) {
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
          .padding(CGFloat(16))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
          .scrollIndicators(.visible)
        }
        .background(ThemeManager.shared.color("semantic.surface"))
        .frame(width: specPx(vm.width))
        .frame(maxWidth: CGFloat(0))
        .background(ThemeManager.shared.color("semantic.surface"))
        .scrollIndicators(.visible)
        VStack() {
          if ((specString(vm.showing) == specString(true)) && (specString(vm.side) == specString("right"))) {
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
          .padding(CGFloat(16))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
          .scrollIndicators(.visible)
        }
        .background(ThemeManager.shared.color("semantic.surface"))
        .frame(width: specPx(vm.width))
        .frame(maxWidth: CGFloat(0))
        .background(ThemeManager.shared.color("semantic.surface"))
        .scrollIndicators(.visible)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.open = open; vm.title = title; vm.side = side; vm.width = width }
  }
}
