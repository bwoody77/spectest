import SwiftUI
import SpecRuntime

@Observable
final class WizardDoneViewModel {
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct WizardDoneView: View {
  @State private var vm = WizardDoneViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      VStack(spacing: CGFloat(16)) {
        Image(systemName: specIconName(specString("check")))
          .font(.system(size: specPx("48px")))
          .foregroundStyle(Color(hex: "#52c41a" as? String ?? "#000"))
        Text(verbatim: specString("Task Created!"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.success-text"))
        Text(verbatim: specString("Your task has been successfully submitted."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.success-mid"))
      }
      .padding(CGFloat(24))
      .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.success-light"), Color(hex: "#b7eb8f")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
      HStack(alignment: .center, spacing: CGFloat(12)) {
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
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
