import SwiftUI
import SpecRuntime

@Observable
final class PopoverViewModel {
  var placement: Any = "bottom"
  var open: Any = false
  func toggle() {
    open = specEq(open, false)
  }
  func close() {
    open = false
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct PopoverView: View {
  @State private var vm = PopoverViewModel()
  var placement: Any = "bottom"
  init(placement: Any = "bottom") { self._vm = State(initialValue: PopoverViewModel()); self.placement = placement }
  var body: some View {
    VStack() {
      VStack() {
        Button(action: { vm.toggle() }) {
        VStack() {
          // slot
        }

        }
        .buttonStyle(.plain)
      }

      .overlay {
        if specEq(vm.open, true) {
          ZStack {
            Color.black.opacity(0.15)
              .ignoresSafeArea()
              .onTapGesture { vm.close() }
            if specEq(vm.open, true) {
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.open, true) && specEq(vm.placement, "bottom")) {
          ZStack {
            if (specEq(vm.open, true) && specEq(vm.placement, "bottom")) {
              // slot
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.open, true) && specEq(vm.placement, "top")) {
          ZStack {
            if (specEq(vm.open, true) && specEq(vm.placement, "top")) {
              // slot
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.open, true) && specEq(vm.placement, "left")) {
          ZStack {
            if (specEq(vm.open, true) && specEq(vm.placement, "left")) {
              // slot
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.open, true) && specEq(vm.placement, "right")) {
          ZStack {
            if (specEq(vm.open, true) && specEq(vm.placement, "right")) {
              // slot
            }
          }
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.placement, placement) { vm.placement = placement } }
    .task(id: specPropsKey([placement])) { if !specEq(vm.placement, placement) { vm.placement = placement } }
  }
}
