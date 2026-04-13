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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
        if specEq(vm.showing, true) {
          ZStack {
            if specEq(vm.showing, true) {
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
            ScrollView([.horizontal, .vertical], showsIndicators: true) {
            VStack() {
              // slot
            }
            }
            .padding(CGFloat(20))
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
          }
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.width, width) { vm.width = width } }
    .task(id: specPropsKey([open, title, width])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.width, width) { vm.width = width } }
  }
}
