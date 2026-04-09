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
        VStack() {
          if (specString(vm.showing) == specString(true)) {
          }
        }
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.4))
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.4))
        .onTapGesture { vm.doClose() }
        VStack(spacing: CGFloat(8)) {
          if (specString(vm.showing) == specString(true)) {
            VStack() {
              Text(specString(vm.title))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              LazyVStack(spacing: CGFloat(8)) {
                ForEach(Array((vm.actions as? [Any] ?? []).enumerated()), id: \.offset) { _idx, action in
                  HStack(alignment: .center, ) {
                    Text(specString((action as? [String: Any])?["label"]))
                      .font(.body.bold())
                      .foregroundStyle(Color(hex: ({ () -> Any in switch specString((action as? [String: Any])?["destructive"]) {
case specString(true): return "rgb(239, 68, 68)"
default: return "#1677ff"
} })() as? String ?? "#000"))
                  }
                  .padding(CGFloat(12))
                  .onTapGesture { vm.selectAction((action as? [String: Any])?["id"]) }
                }
              }
            }
            .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
          }
          HStack(alignment: .center, ) {
            Text(specString("Cancel"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
          }
          .padding(CGFloat(12))
          .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
          .onTapGesture { vm.doClose() }
        }
        .padding(CGFloat(8))
        .padding(.bottom, CGFloat(0))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.open = open; vm.title = title; vm.actions = actions }
  }
}
