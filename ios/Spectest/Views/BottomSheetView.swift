import SwiftUI
import SpecRuntime

@Observable
final class BottomSheetViewModel {
  var backdrop: Any = true
  var initialSnap: Any = 0
  var open: Any = false
  var showHandle: Any = true
  var snapPoints: Any = [0.5, 1] as [Any]
  var showing: Any = false
  var currentY: Any = 0
  var snapIndex: Any = 0
  var dragging: Any = false
  var sheetTransform: Any { ({ () -> Any in switch specString(showing) {
case specString(true): return ({ () -> Any in switch specString(dragging) {
case specString(true): return specAdd(specAdd("translateY(", currentY), "px)")
default: return "translateY(0)"
} })()
default: return "translateY(100%)"
} })() }
  var sheetHeight: Any { ({ () -> Any in switch specString(snapIndex) {
case specString(0): return ({ () -> Any in switch specString((specDouble(specLength(snapPoints)) > specDouble(0))) {
case specString(true): return specAdd((specDouble((snapPoints as? [Any])?[0]) * specDouble(100)), "vh")
default: return "50vh"
} })()
default: return ({ () -> Any in switch specString((specDouble(specLength(snapPoints)) > specDouble(snapIndex))) {
case specString(true): return specAdd((specDouble(specGet(snapPoints, snapIndex)) * specDouble(100)), "vh")
default: return "100vh"
} })()
} })() }
  func doOpen() {
    showing = true
    snapIndex = initialSnap
    // unsupported: builtin-call
  }
  func doClose() {
    showing = false
    dragging = false
    currentY = 0
    // unsupported: builtin-call
    /* event callback */
  }
  func handleDrag(_ delta: Any) {
    dragging = true
    currentY = ({ () -> Any in switch specString((specDouble(specGet(delta, "y")) > specDouble(0))) {
case specString(true): return specGet(delta, "y")
default: return 0
} })()
  }
  func handleDragEnd(_ delta: Any) {
    dragging = false
    ({ () -> Any in switch specString(((specDouble(specGet(delta, "velocityY")) > specDouble(500)) || (specDouble(currentY) > specDouble(150)))) {
case specString(true): return doClose()
default: return resetPosition()
} })()
  }
  func resetPosition() {
    currentY = 0
  }
  func snapTo(_ index: Any) {
    snapIndex = index
    /* event callback */
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct BottomSheetView: View {
  @State private var vm = BottomSheetViewModel()
  var backdrop: Any = true
  var initialSnap: Any = 0
  var open: Any = false
  var showHandle: Any = true
  var snapPoints: Any = [0.5, 1] as [Any]
  init(backdrop: Any = true, initialSnap: Any = 0, open: Any = false, showHandle: Any = true, snapPoints: Any = [0.5, 1] as [Any]) { self._vm = State(initialValue: BottomSheetViewModel()); self.backdrop = backdrop; self.initialSnap = initialSnap; self.open = open; self.showHandle = showHandle; self.snapPoints = snapPoints }
  var body: some View {
    VStack() {
      VStack() {
      }

      .overlay {
        if (specEq(vm.showing, true) && specEq(vm.backdrop, true)) {
          ZStack {
            Color.black.opacity(0.15)
              .ignoresSafeArea()
              .onTapGesture { vm.doClose() }
            if (specEq(vm.showing, true) && specEq(vm.backdrop, true)) {
            }
          }
        }
      }
      .overlay {
        if specEq(vm.showing, true) {
          ZStack {
            if specEq(vm.showing, true) {
              HStack(alignment: .center, ) {
                if specEq(vm.showHandle, true) {
                  VStack() {
                  }
                  .opacity(CGFloat(0.4))
                  .frame(width: CGFloat(36))
                  .frame(height: CGFloat(4))
                  .background(ThemeManager.shared.color("semantic.border-strong"), in: RoundedRectangle(cornerRadius: CGFloat(2)))
                }
              }
              .padding(.top, CGFloat(8))
              .padding(.bottom, CGFloat(8))
            }
            ScrollView([.horizontal, .vertical], showsIndicators: true) {
            VStack() {
              // slot
            }
            }
            .padding(.bottom, CGFloat(0))
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
          }
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.snapPoints, snapPoints) { vm.snapPoints = snapPoints }; if !specEq(vm.initialSnap, initialSnap) { vm.initialSnap = initialSnap }; if !specEq(vm.showHandle, showHandle) { vm.showHandle = showHandle }; if !specEq(vm.backdrop, backdrop) { vm.backdrop = backdrop } }
    .task(id: specPropsKey([open, snapPoints, initialSnap, showHandle, backdrop])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.snapPoints, snapPoints) { vm.snapPoints = snapPoints }; if !specEq(vm.initialSnap, initialSnap) { vm.initialSnap = initialSnap }; if !specEq(vm.showHandle, showHandle) { vm.showHandle = showHandle }; if !specEq(vm.backdrop, backdrop) { vm.backdrop = backdrop } }
  }
}
