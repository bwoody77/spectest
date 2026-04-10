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
      }

      .overlay {
        if specEq(vm.showing, true) {
          ZStack {
            Color.black.opacity(0.15)
              .ignoresSafeArea()
              .onTapGesture { vm.doClose() }
            if specEq(vm.showing, true) {
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.showing, true) && specEq(vm.side, "left")) {
          ZStack {
            if (specEq(vm.showing, true) && specEq(vm.side, "left")) {
              HStack(alignment: .center, ) {
                Text(verbatim: specString(vm.title))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                HStack(alignment: .center, ) {
                  Text(verbatim: specString("u00D7"))
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
        }
      }
      .overlay {
        if (specEq(vm.showing, true) && specEq(vm.side, "right")) {
          ZStack {
            if (specEq(vm.showing, true) && specEq(vm.side, "right")) {
              HStack(alignment: .center, ) {
                Text(verbatim: specString(vm.title))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                HStack(alignment: .center, ) {
                  Text(verbatim: specString("u00D7"))
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
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.open = open; vm.title = title; vm.side = side; vm.width = width }
  }
}
