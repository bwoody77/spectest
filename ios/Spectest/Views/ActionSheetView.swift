import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class ActionSheetViewModel {
  var actions: Any = [] as [Any]
  var open: Any = false
  var title: Any = ""
  var showing: Any = false
  func doOpen() {
    showing = true
    // web-only: lockScroll
  }
  func doClose() {
    showing = false
    // web-only: unlockScroll
    dispatch("close")
  }
  func selectAction(_ actionId: Any) {
    dispatch("select", [actionId] as [Any])
    doClose()
  }
  func _specWatch_open() async {
    ({ () -> Any in switch specString(open) {
case specString(true): return doOpen()
default: return doClose()
} })()
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct ActionSheetView: View {
  @State private var vm = ActionSheetViewModel()
  var actions: Any = [] as [Any]
  var open: Any = false
  var title: Any = ""
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(actions: Any = [] as [Any], open: Any = false, title: Any = "", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = ActionSheetViewModel(); _m.actions = actions; _m.open = open; _m.title = title; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.actions = actions; self.open = open; self.title = title; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(actions) + "\u{1}" + specChangeKey(open) + "\u{1}" + specChangeKey(title) }
  @State private var _specWatchRan_open = false
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      Color.clear.frame(width: 0, height: 0).sheet(isPresented: Binding(get: { (vm.showing) as? Bool ?? false }, set: { shown in if !shown { vm.showing = false; specSheetDismiss { vm.doClose() } } })) {
        ScrollView(.vertical, showsIndicators: true) {
          VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: CGFloat(8)) {
              VStack(alignment: .leading, spacing: 0) {
                if specNeq(vm.title, "") {
                Text(verbatim: specString(vm.title))
                  .font(.caption2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  .textCase(.uppercase)
                }
                ForEach(Array(specArr(vm.actions).enumerated()), id: \.offset) { _idx, action in
                  Button(action: { specClick { vm.selectAction(specGet(action, "id")) } }) {
                  HStack(alignment: .center, spacing: 0) {
                    Spacer(minLength: 0)
                    Text(verbatim: specString(specGet(action, "label")))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(({ () -> Color in switch specString(specGet(action, "destructive")) {
case specString(true): return Color(hex: "rgb(239, 68, 68)" as? String ?? "transparent")
default: return ThemeManager.shared.color("accent")
} })())
                    Spacer(minLength: 0)
                  }
                  .frame(maxWidth: .infinity)
                  .padding(.top, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
                  .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
                  .frame(maxWidth: .infinity, alignment: .center)
                  .specBorderSides(nil, top: ThemeManager.shared.rawToken("borders-default"), right: nil, bottom: nil, left: nil, radius: CGFloat(0))
                  .hoverEffect(.highlight)
                    .contentShape(Rectangle())
                  }
                  .buttonStyle(.plain)
                }
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
              .clipShape(RoundedRectangle(cornerRadius: CGFloat(14)))
              Button(action: { specClick { vm.doClose() } }) {
              HStack(alignment: .center, spacing: 0) {
                Spacer(minLength: 0)
                Text(verbatim: specString("Cancel"))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-strong-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("accent"))
                Spacer(minLength: 0)
              }
              .frame(maxWidth: .infinity)
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: CGFloat(14)))
              .clipShape(RoundedRectangle(cornerRadius: CGFloat(14)))
              .hoverEffect(.highlight)
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(ThemeManager.shared.color("background").ignoresSafeArea())
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.actions = actions
      vm.open = open
      vm.title = title
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onChange(of: specChangeKey(open)) { _, _ in vm.open = open; Task { @MainActor in await vm._specWatch_open() } }
    .task { if !_specWatchRan_open { _specWatchRan_open = true; if !specSame(open, false) { await vm._specWatch_open() } } }
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.open, open) { vm.open = open }; if !specSame(vm.title, title) { vm.title = title }; if !specSame(vm.actions, actions) { vm.actions = actions } }
    .task(id: specPropsKey([open, title, actions])) { if !specSame(vm.open, open) { vm.open = open }; if !specSame(vm.title, title) { vm.title = title }; if !specSame(vm.actions, actions) { vm.actions = actions } }
  }
}
