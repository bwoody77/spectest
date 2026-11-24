import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class WizardDoneViewModel {
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct WizardDoneView: View {
  @State private var vm = WizardDoneViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = WizardDoneViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        Image(systemName: specIconName(specString("check")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xxl"))))
          .foregroundStyle(ThemeManager.shared.color("success"))
        Text(verbatim: specString("Task Created!"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("success-text"))
        Text(verbatim: specString("Your task has been successfully submitted."))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("success-mid"))
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-6")))
      .background(ThemeManager.shared.color("gradient-stat-success-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-lg")))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Spacer(minLength: 0)
        Button(action: { specClick { Task { @MainActor in await vm.dispatch("restart", nil) } } }) {
          Text(specString("Create Another"))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
        }
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
