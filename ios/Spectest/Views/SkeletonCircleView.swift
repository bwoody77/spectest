import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class SkeletonCircleViewModel {
  var size: Any = "40px"
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct SkeletonCircleView: View {
  @State private var vm = SkeletonCircleViewModel()
  var size: Any = "40px"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(size: Any = "40px", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = SkeletonCircleViewModel(); _m.size = size; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.size = size; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(size) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
      }
      .specFrameWidth(vm.size, alignment: .leading)
      .specFrameHeight(specPx(vm.size), alignment: .top)
      .background(ThemeManager.shared.color("skeleton-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
      .overlay(alignment: .topLeading) {
        ZStack(alignment: .topLeading) {
          VStack(alignment: .leading, spacing: 0) {
          }
          .frame(maxWidth: .infinity)
          .frame(maxHeight: .infinity)
          .background(LinearGradient(colors: [Color.clear, Color(.sRGB, red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.6), Color.clear], startPoint: .leading, endPoint: .trailing))
          .specAnimation("wave")
          .padding(.top, CGFloat(0))
          .padding(.bottom, CGFloat(0))
          .offset(x: CGFloat(0), y: CGFloat(0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
      }
      .specFullBasis(specString(vm.size) == "100%")
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .specFullBasis(specString(vm.size) == "100%")
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.size = size
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.size, size) { vm.size = size } }
    .task(id: specPropsKey([size])) { if !specSame(vm.size, size) { vm.size = size } }
  }
}
