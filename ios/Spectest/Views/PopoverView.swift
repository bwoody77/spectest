import SwiftUI
import SpecRuntime

@Observable
final class PopoverViewModel {
  var placement: Any = "bottom"
  var open: Any = false
  func toggle() {
    open = (specString(open) == specString(false))
  }
  func close() {
    open = false
  }
}

struct PopoverView: View {
  @State private var vm = PopoverViewModel()
  var placement: Any = "bottom"
  init(placement: Any = "bottom") { self._vm = State(initialValue: PopoverViewModel()); self.placement = placement }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
          // slot
        }

        .onTapGesture { vm.toggle() }
        VStack() {
          if (specString(vm.open) == specString(true)) {
          }
        }

        .onTapGesture { vm.close() }
        VStack(spacing: CGFloat(8)) {
          if ((specString(vm.open) == specString(true)) && (specString(vm.placement) == specString("bottom"))) {
            // slot
          }
        }
        .padding(CGFloat(16))
        .frame(minWidth: CGFloat(240))
        .frame(maxWidth: CGFloat(0))
        .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(12)))
        VStack(spacing: CGFloat(8)) {
          if ((specString(vm.open) == specString(true)) && (specString(vm.placement) == specString("top"))) {
            // slot
          }
        }
        .padding(CGFloat(16))
        .frame(minWidth: CGFloat(240))
        .frame(maxWidth: CGFloat(0))
        .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(12)))
        VStack(spacing: CGFloat(8)) {
          if ((specString(vm.open) == specString(true)) && (specString(vm.placement) == specString("left"))) {
            // slot
          }
        }
        .padding(CGFloat(16))
        .frame(minWidth: CGFloat(240))
        .frame(maxWidth: CGFloat(0))
        .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(12)))
        VStack(spacing: CGFloat(8)) {
          if ((specString(vm.open) == specString(true)) && (specString(vm.placement) == specString("right"))) {
            // slot
          }
        }
        .padding(CGFloat(16))
        .frame(minWidth: CGFloat(240))
        .frame(maxWidth: CGFloat(0))
        .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(12)))
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.placement = placement }
  }
}
