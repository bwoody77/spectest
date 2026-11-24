import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class InfoBoxViewModel {
  var title: Any = "Info Box"
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct InfoBoxView: View {
  @State private var vm = InfoBoxViewModel()
  var title: Any = "Info Box"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  var specChildren: AnyView = AnyView(EmptyView())
  init(title: Any = "Info Box", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil, specChildren: AnyView = AnyView(EmptyView())) { let _m = InfoBoxViewModel(); _m.title = title; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.title = title; self.onDispatch = onDispatch; self.specChildren = specChildren }
  private var _specParamKey: String { specChangeKey(title) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
        Text(verbatim: specString(vm.title))
          .font(.footnote)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        specChildren
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.title = title
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.title, title) { vm.title = title } }
    .task(id: specPropsKey([title])) { if !specSame(vm.title, title) { vm.title = title } }
  }
}
