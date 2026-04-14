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
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  ForEach(Array(specArr(vm.actions).enumerated()), id: \.offset) { _idx, action in
                    Button(action: { vm.selectAction(specGet(action, "id")) }) {
                    HStack(alignment: .center, ) {
                      Text(verbatim: specString(specGet(action, "label")))
                        .font(.body.bold())
                        .foregroundStyle(Color(hex: ({ () -> Any in switch specString(specGet(action, "destructive")) {
case specString(true): return "rgb(239, 68, 68)"
default: return "#1677ff"
} })() as? String ?? "transparent"))
                    }
                    .padding(CGFloat(12))
                    }
                    .buttonStyle(.plain)
                  }
                }
                .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
                Button(action: { vm.doClose() }) {
                HStack(alignment: .center, ) {
                  Text(verbatim: specString("Cancel"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                }
                .padding(CGFloat(12))
                .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
                }
                .buttonStyle(.plain)
              }
              .padding(CGFloat(8))
              .padding(.bottom, CGFloat(0))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.actions, actions) { vm.actions = actions } }
    .task(id: specPropsKey([open, title, actions])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.actions, actions) { vm.actions = actions } }
  }
}
