import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class CountDisplayViewModel {
  var value: Any? = nil
  var changes: Any = 0
  func _specWatch_value() async {
    changes = specAdd(changes, 1)
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct CountDisplayView: View {
  @State private var vm = CountDisplayViewModel()
  var value: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(value: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = CountDisplayViewModel(); _m.value = value; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.value = value; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(value) }
  @State private var _specWatchRan_value = false
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
        Text(verbatim: specString("Received value: \(specString(vm.value))"))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("@watch fired \(specString(vm.changes)) time(s)"))
          .font(.footnote)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.value = value
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onChange(of: specChangeKey(value)) { _, _ in vm.value = value; Task { @MainActor in await vm._specWatch_value() } }
    .task { if !_specWatchRan_value { _specWatchRan_value = true; if !specIsNil(value) { await vm._specWatch_value() } } }
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.value, value) { vm.value = value } }
    .task(id: specPropsKey([value])) { if !specSame(vm.value, value) { vm.value = value } }
  }
}
