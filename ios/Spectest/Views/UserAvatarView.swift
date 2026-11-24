import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class UserAvatarViewModel {
  var bgColor: Any? = nil
  var name: Any? = nil
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct UserAvatarView: View {
  @State private var vm = UserAvatarViewModel()
  var bgColor: Any? = nil
  var name: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(bgColor: Any? = nil, name: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = UserAvatarViewModel(); _m.bgColor = bgColor; _m.name = name; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.bgColor = bgColor; self.name = name; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(bgColor) + "\u{1}" + specChangeKey(name) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center, spacing: 0) {
        Text(verbatim: specString(vm.name))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("background"))
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
      .background(Color(hex: vm.bgColor as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-full"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-full"))))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-full")))
      .hoverEffect(.highlight)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.bgColor = bgColor
      vm.name = name
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.name, name) { vm.name = name }; if !specSame(vm.bgColor, bgColor) { vm.bgColor = bgColor } }
    .task(id: specPropsKey([name, bgColor])) { if !specSame(vm.name, name) { vm.name = name }; if !specSame(vm.bgColor, bgColor) { vm.bgColor = bgColor } }
  }
}
