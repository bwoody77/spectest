import SwiftUI
import SpecRuntime

@Observable
final class ActionSheetViewModel {
  var actions: Any = [] as [Any]
  var open: Any = false
  var title: Any = ""
  var showing: Any = false
  func doOpen() {
    showing = true
    // unsupported: builtin-call
  }
  func doClose() {
    showing = false
    // unsupported: builtin-call
    /* event callback */
  }
  func selectAction(_ actionId: Any) {
    /* event callback */
    doClose()
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct ActionSheetView: View {
  @State private var vm = ActionSheetViewModel()
  var actions: Any = [] as [Any]
  var open: Any = false
  var title: Any = ""
  init(actions: Any = [] as [Any], open: Any = false, title: Any = "") { self._vm = State(initialValue: ActionSheetViewModel()); self.actions = actions; self.open = open; self.title = title }
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
              VStack() {
                Text(verbatim: specString(vm.title))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                LazyVStack(spacing: CGFloat(8)) {
                  ForEach(Array((vm.actions as? [Any] ?? []).enumerated()), id: \.offset) { _idx, action in
                    HStack(alignment: .center, ) {
                      Text(verbatim: specString(specGet(action, "label")))
                        .font(.body.bold())
                        .foregroundStyle(Color(hex: ({ () -> Any in switch specString(specGet(action, "destructive")) {
case specString(true): return "rgb(239, 68, 68)"
default: return "#1677ff"
} })() as? String ?? "#000"))
                    }
                    .padding(CGFloat(12))
                    .onTapGesture { vm.selectAction(specGet(action, "id")) }
                  }
                }
              }
              .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
            }
            HStack(alignment: .center, ) {
              Text(verbatim: specString("Cancel"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }
            .padding(CGFloat(12))
            .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
            .onTapGesture { vm.doClose() }
          }
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.open = open; vm.title = title; vm.actions = actions }
  }
}
