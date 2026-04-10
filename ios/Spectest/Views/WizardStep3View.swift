import SwiftUI
import SpecRuntime

@Observable
final class WizardStep3ViewModel {
  var confirmed: Any = false
  func setConfirmed(_ v: Any) {
    confirmed = v
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct WizardStep3View: View {
  @State private var vm = WizardStep3ViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      Text(verbatim: specString("Step 3: Review & Confirm"))
        .font(.title3.bold())
      Text(verbatim: specString("Please review your task details and confirm submission."))
        .font(.callout.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
        VStack(spacing: CGFloat(12)) {
          Toggle(specString("I confirm this task is correct"), isOn: Binding(get: { vm.confirmed as? Bool ?? false }, set: { vm.confirmed = $0 }))
            .toggleStyle(.automatic)
        }
        .padding(CGFloat(16))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Button(action: { Task { @MainActor in await /* unsupported: dispatch */ Optional<Any>.none as Any } }) {
          Text(specString("Back"))
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.blue)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        Button(action: { Task { @MainActor in await /* unsupported: dispatch */ Optional<Any>.none as Any } }) {
          Text(specString("Submit"))
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.blue, in: RoundedRectangle(cornerRadius: 8))
        }
        .disabled((!((vm.confirmed) as? Bool ?? false)) as? Bool ?? false)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
