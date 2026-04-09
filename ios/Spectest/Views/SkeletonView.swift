import SwiftUI
import SpecRuntime

@Observable
final class SkeletonViewModel {
  var height: Any = ""
  var width: Any = "100%"
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
        .frame(height: CGFloat(80))
        .background(Color(.separator), in: RoundedRectangle(cornerRadius: CGFloat(8)))
        HStack(alignment: .center, spacing: CGFloat(12)) {
          VStack() {
          }
          .opacity(CGFloat(0.7))
          .frame(width: CGFloat(48))
          .frame(height: CGFloat(48))
          .background(Color(.separator), in: RoundedRectangle(cornerRadius: CGFloat(9999)))
          VStack(spacing: CGFloat(8)) {
            VStack() {
            }
            .opacity(CGFloat(0.7))
            .frame(height: CGFloat(14))
            .background(Color(.separator), in: RoundedRectangle(cornerRadius: CGFloat(6)))
            VStack() {
            }
            .opacity(CGFloat(0.7))
            .frame(width: CGFloat(0))
            .frame(height: CGFloat(14))
            .background(Color(.separator), in: RoundedRectangle(cornerRadius: CGFloat(6)))
          }
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
        }

      }
      .frame(width: specPx(vm.width))
      .frame(height: specPx(vm.height))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.width = width; vm.height = height }
  }
}
