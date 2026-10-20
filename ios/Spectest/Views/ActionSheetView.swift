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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ActionSheetView: View {
  @State private var vm = ActionSheetViewModel()
  var actions: Any = [] as [Any]
  var open: Any = false
  var title: Any = ""
  init(actions: Any = [] as [Any], open: Any = false, title: Any = "") { self._vm = State(initialValue: ActionSheetViewModel()); self.actions = actions; self.open = open; self.title = title }
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
              VStack(spacing: CGFloat(8)) {
                VStack() {
                  Text(verbatim: specString(vm.title))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  ForEach(Array(specArr(vm.actions).enumerated()), id: \.offset) { _idx, action in
                    Button(action: { vm.selectAction(specGet(action, "id")) }) {
                    HStack(alignment: .center) {
                      Text(verbatim: specString(specGet(action, "label")))
                        .font(.body.bold())
                        .foregroundStyle(({ () -> Color in switch specString(specGet(action, "destructive")) {
case specString(true): return Color(hex: "rgb(239, 68, 68)" as? String ?? "transparent")
default: return ThemeManager.shared.color("accent")
} })())
                    }
                    .padding(ThemeManager.shared.size("spacing-3"))
                    .hoverEffect(.highlight)
                    }
                    .buttonStyle(.plain)
                  }
                }
                .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
                Button(action: { vm.doClose() }) {
                HStack(alignment: .center) {
                  Text(verbatim: specString("Cancel"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("accent"))
                }
                .padding(ThemeManager.shared.size("spacing-3"))
                .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
                .hoverEffect(.highlight)
                }
                .buttonStyle(.plain)
              }
              .padding(ThemeManager.shared.size("spacing-2"))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.actions, actions) { vm.actions = actions } }
    .task(id: specPropsKey([open, title, actions])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.actions, actions) { vm.actions = actions } }
  }
}
