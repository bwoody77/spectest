import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class WizardStep3ViewModel {
  var confirmed: Any = false
  func setConfirmed(_ v: Any) {
    confirmed = v
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct WizardStep3View: View {
  @State private var vm = WizardStep3ViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = WizardStep3ViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      Text(verbatim: specString("Step 3: Review & Confirm"))
        .font(.title)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
      Text(verbatim: specString("Please review your task details and confirm submission."))
        .font(.footnote)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      HStack(alignment: .top, spacing: 12) {
        Image(systemName: specAlertIcon(specString("info")))
          .foregroundStyle(specAlertColor(specString("info")))
        VStack(alignment: .leading, spacing: 4) {
          Text(specString("Editable Later")).font(.subheadline.weight(.semibold))
          Text(specString("All fields can be edited after creation.")).font(.subheadline)
        }
        Spacer(minLength: 0)
      }
      .padding(12)
      .background(specAlertColor(specString("info")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Toggle(specString("I confirm this task is correct"), isOn: Binding(get: { specTruthy(vm.confirmed) }, set: { newValue in let v: Any = newValue; vm.confirmed = v }))
            .toggleStyle(SpecCheckToggleStyle(tint: nil))
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Spacer(minLength: 0)
        Button(action: { specClick { Task { @MainActor in await vm.dispatch("back", nil) } } }) {
          Text(specString("Back"))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline.weight(.medium))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        Button(action: { specClick { Task { @MainActor in await vm.dispatch("submit", nil) } } }) {
          Text(specString("Submit"))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
        }
        .disabled((!((vm.confirmed) as? Bool ?? false)) as? Bool ?? false)
        .opacity(((!((vm.confirmed) as? Bool ?? false)) as? Bool ?? false) ? 0.5 : 1)
      }
      .frame(maxWidth: .infinity)

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
