import SwiftUI
import SpecRuntime

@Observable
final class SkeletonViewModel {
  var height: Any = ""
  var width: Any = "100%"
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct SkeletonView: View {
  @State private var vm = SkeletonViewModel()
  var height: Any = ""
  var width: Any = "100%"
  init(height: Any = "", width: Any = "100%") { self._vm = State(initialValue: SkeletonViewModel()); self.height = height; self.width = width }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(12)) {
        VStack() {
        }
        .opacity(CGFloat(0.7))
        .specFrameHeight(CGFloat(80))
        .background(Color(hex: "#e2e8f0"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        HStack(alignment: .center, spacing: CGFloat(12)) {
          VStack() {
          }
          .opacity(CGFloat(0.7))
          .frame(width: CGFloat(48))
          .specFrameHeight(CGFloat(48))
          .background(Color(hex: "#e2e8f0"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
          VStack(spacing: CGFloat(8)) {
            VStack() {
            }
            .opacity(CGFloat(0.7))
            .specFrameHeight(CGFloat(14))
            .background(Color(hex: "#e2e8f0"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
            VStack() {
            }
            .opacity(CGFloat(0.7))
            .frame(width: CGFloat(0))
            .specFrameHeight(CGFloat(14))
            .background(Color(hex: "#e2e8f0"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
          }
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
        }

      }
      .frame(width: specPx(vm.width))
      .specFrameHeight(specPx(vm.height))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.width, width) { vm.width = width }; if !specEq(vm.height, height) { vm.height = height } }
    .task(id: specPropsKey([width, height])) { if !specEq(vm.width, width) { vm.width = width }; if !specEq(vm.height, height) { vm.height = height } }
  }
}
