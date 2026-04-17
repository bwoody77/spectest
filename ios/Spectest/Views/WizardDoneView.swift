import SwiftUI
import SpecRuntime

@Observable
final class WizardDoneViewModel {
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct WizardDoneView: View {
  @State private var vm = WizardDoneViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      VStack(spacing: ThemeManager.shared.size("spacing-4")) {
        Image(systemName: specIconName(specString("check")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xxl"))))
          .foregroundStyle(ThemeManager.shared.color("success"))
        Text(verbatim: specString("Task Created!"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("success-text"))
        Text(verbatim: specString("Your task has been successfully submitted."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("success-mid"))
      }
      .padding(ThemeManager.shared.size("spacing-6"))
      .background(ThemeManager.shared.color("gradient-stat-success-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Button(action: { Task { @MainActor in await vm.dispatch("restart") } }) {
          Text(specString("Create Another"))
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.blue, in: RoundedRectangle(cornerRadius: 8))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
