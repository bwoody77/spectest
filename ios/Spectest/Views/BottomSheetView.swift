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
case specString(0): return ({ () -> Any in switch specString(((specLength(snapPoints) as? Double ?? 0) > (0 as? Double ?? 0))) {
case specString(true): return specAdd((((snapPoints as? [Any])?[0 as? Int ?? 0] as? Double ?? 0) * (100 as? Double ?? 0)), "vh")
default: return "50vh"
} })()
default: return ({ () -> Any in switch specString(((specLength(snapPoints) as? Double ?? 0) > (snapIndex as? Double ?? 0))) {
case specString(true): return specAdd((((snapPoints as? [Any])?[snapIndex as? Int ?? 0] as? Double ?? 0) * (100 as? Double ?? 0)), "vh")
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
    currentY = ({ () -> Any in switch specString((((delta as? [String: Any])?["y"] as? Double ?? 0) > (0 as? Double ?? 0))) {
case specString(true): return (delta as? [String: Any])?["y"]
default: return 0
} })()
  }
  func handleDragEnd(_ delta: Any) {
    dragging = false
    ({ () -> Any in switch specString(((((delta as? [String: Any])?["velocityY"] as? Double ?? 0) > (500 as? Double ?? 0)) || ((currentY as? Double ?? 0) > (150 as? Double ?? 0)))) {
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
        VStack() {
          if ((specString(vm.showing) == specString(true)) && (specString(vm.backdrop) == specString(true))) {
          }
        }
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.4))
        .background(Color(.sRGB, red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 0.4))
        .onTapGesture { vm.doClose() }
        VStack() {
          if (specString(vm.showing) == specString(true)) {
            HStack(alignment: .center, ) {
              if (specString(vm.showHandle) == specString(true)) {
                VStack() {
                }
                .opacity(CGFloat(0.4))
                .frame(width: CGFloat(36))
                .frame(height: CGFloat(4))
                .background(Color(.tertiaryLabel), in: RoundedRectangle(cornerRadius: CGFloat(2)))
              }
            }
            .padding(.top, CGFloat(8))
            .padding(.bottom, CGFloat(8))
          }
          VStack() {
            // slot
          }
          .padding(.bottom, CGFloat(0))
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
          .scrollIndicators(.visible)
        }
        .frame(height: specPx(vm.sheetHeight))
        .frame(maxHeight: CGFloat(0))
        .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(0)))
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.open = open; vm.snapPoints = snapPoints; vm.initialSnap = initialSnap; vm.showHandle = showHandle; vm.backdrop = backdrop }
  }
}
