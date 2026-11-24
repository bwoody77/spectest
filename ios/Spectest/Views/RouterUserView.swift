import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class RouterUserViewModel {
  var userId: Any? = nil
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct RouterUserView: View {
  @State private var vm = RouterUserViewModel()
  var userId: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(userId: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = RouterUserViewModel(); _m.userId = userId; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.userId = userId; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(userId) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Text(verbatim: specString("User Profile"))
          .font(.title2)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("Route: /users/\(specString(vm.userId))"))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        Text(verbatim: specString("The ':id' segment from the URL pattern is extracted into _routeParams.id and passed as a prop."))
          .font(.footnote)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          HStack(alignment: .center, spacing: 0) {
            Text(verbatim: ({ () -> String in
          if (vm.userId) as? Bool ?? false { return specString((vm.userId as? [Any])?[0]) }
          return specString("?")
        })())
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(Color(hex: "#fff"))
          }
          .frame(width: CGFloat(40), alignment: .center)
          .specFrameHeight(CGFloat(40), alignment: .center)
          .background(ThemeManager.shared.color("primary"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
          .clipShape(RoundedRectangle(cornerRadius: CGFloat(0)))
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("User #\(specString(vm.userId))"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("user\(specString(vm.userId))@example.com"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        .frame(maxWidth: .infinity, alignment: .center)
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.userId = userId
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.userId, userId) { vm.userId = userId } }
    .task(id: specPropsKey([userId])) { if !specSame(vm.userId, userId) { vm.userId = userId } }
  }
}
