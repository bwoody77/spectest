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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
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
      Color.clear.frame(width: 0, height: 0)
        .overlay {
          if (vm.showing) as? Bool ?? false {
            ZStack {
              Color.black.opacity(0.15).ignoresSafeArea()
                .onTapGesture {
                  vm.doClose()
                }
              ScrollView(.horizontal, showsIndicators: true) {
              VStack() {
                if specEq(vm.side, "left") {
                  HStack(alignment: .center) {
                    Text(verbatim: specString(vm.title))
                      .font(.headline.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Button(action: { vm.doClose() }) {
                    HStack(alignment: .center) {
                      Text(verbatim: specString("u00D7"))
                        .font(.headline.bold())
                        .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                    .frame(width: CGFloat(32))
                    .specFrameHeight(CGFloat(32))
                    .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                    .hoverEffect(.highlight)
                    }
                    .buttonStyle(.plain)
                  }
                  .padding(ThemeManager.shared.size("spacing-4"))
                }
                ScrollView(.horizontal, showsIndicators: true) {
                VStack() {
                  // slot
                }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .frame(maxWidth: .infinity)
              }
              }
              .background(ThemeManager.shared.color("surface"))
              .frame(width: specPx(vm.width))
              .frame(maxWidth: CGFloat(0))
              .background(ThemeManager.shared.color("surface"))
              ScrollView(.horizontal, showsIndicators: true) {
              VStack() {
                if specEq(vm.side, "right") {
                  HStack(alignment: .center) {
                    Text(verbatim: specString(vm.title))
                      .font(.headline.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Button(action: { vm.doClose() }) {
                    HStack(alignment: .center) {
                      Text(verbatim: specString("u00D7"))
                        .font(.headline.bold())
                        .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                    .frame(width: CGFloat(32))
                    .specFrameHeight(CGFloat(32))
                    .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
                    .hoverEffect(.highlight)
                    }
                    .buttonStyle(.plain)
                  }
                  .padding(ThemeManager.shared.size("spacing-4"))
                }
                ScrollView(.horizontal, showsIndicators: true) {
                VStack() {
                  // slot
                }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .frame(maxWidth: .infinity)
              }
              }
              .background(ThemeManager.shared.color("surface"))
              .frame(width: specPx(vm.width))
              .frame(maxWidth: CGFloat(0))
              .background(ThemeManager.shared.color("surface"))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.side, side) { vm.side = side }; if !specEq(vm.width, width) { vm.width = width } }
    .task(id: specPropsKey([open, title, side, width])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.side, side) { vm.side = side }; if !specEq(vm.width, width) { vm.width = width } }
  }
}
