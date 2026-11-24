import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class SkeletonBlockViewModel {
  var height: Any = "80px"
  var radius: Any = "10px"
  var width: Any = "100%"
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct SkeletonBlockView: View {
  @State private var vm = SkeletonBlockViewModel()
  var height: Any = "80px"
  var radius: Any = "10px"
  var width: Any = "100%"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(height: Any = "80px", radius: Any = "10px", width: Any = "100%", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = SkeletonBlockViewModel(); _m.height = height; _m.radius = radius; _m.width = width; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.height = height; self.radius = radius; self.width = width; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(height) + "\u{1}" + specChangeKey(radius) + "\u{1}" + specChangeKey(width) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
      }
      .specFrameWidth(vm.width, alignment: .leading)
      .specFrameHeight(specPx(vm.height), alignment: .top)
      .background(ThemeManager.shared.color("skeleton-bg"), in: RoundedRectangle(cornerRadius: specPx(vm.radius)))
      .clipShape(RoundedRectangle(cornerRadius: specPx(vm.radius)))
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
        .clipShape(RoundedRectangle(cornerRadius: specPx(vm.radius)))
      }
      .specFullBasis(specString(vm.width) == "100%")
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .specFullBasis(specString(vm.width) == "100%")
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.height = height
      vm.radius = radius
      vm.width = width
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.width, width) { vm.width = width }; if !specSame(vm.height, height) { vm.height = height }; if !specSame(vm.radius, radius) { vm.radius = radius } }
    .task(id: specPropsKey([width, height, radius])) { if !specSame(vm.width, width) { vm.width = width }; if !specSame(vm.height, height) { vm.height = height }; if !specSame(vm.radius, radius) { vm.radius = radius } }
  }
}
