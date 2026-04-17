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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
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
        Color.clear.frame(width: 0, height: 0)
          .overlay {
            if (vm.open) as? Bool ?? false {
              ZStack {
                Color.clear.ignoresSafeArea()
                  .onTapGesture {
                    vm.close()
                  }
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  if specEq(vm.placement, "bottom") {
                    // slot
                  }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .frame(minWidth: CGFloat(240))
                .frame(maxWidth: CGFloat(0))
                .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  if specEq(vm.placement, "top") {
                    // slot
                  }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .frame(minWidth: CGFloat(240))
                .frame(maxWidth: CGFloat(0))
                .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  if specEq(vm.placement, "left") {
                    // slot
                  }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .frame(minWidth: CGFloat(240))
                .frame(maxWidth: CGFloat(0))
                .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
                VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                  if specEq(vm.placement, "right") {
                    // slot
                  }
                }
                .padding(ThemeManager.shared.size("spacing-4"))
                .frame(minWidth: CGFloat(240))
                .frame(maxWidth: CGFloat(0))
                .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
              }
            }
          }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.placement, placement) { vm.placement = placement } }
    .task(id: specPropsKey([placement])) { if !specEq(vm.placement, placement) { vm.placement = placement } }
  }
}
