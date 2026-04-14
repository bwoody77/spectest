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
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
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
      Color.clear.frame(width: 0, height: 0)
        .overlay {
          if (vm.showing) as? Bool ?? false {
            ZStack {
              Color.black.opacity(0.15).ignoresSafeArea()
                .onTapGesture {
                  vm.doClose()
                }
              VStack() {
                HStack(alignment: .center) {
                  if specEq(vm.showHandle, true) {
                    VStack() {
                    }
                    .opacity(CGFloat(0.4))
                    .frame(width: CGFloat(36))
                    .specFrameHeight(CGFloat(4))
                    .background(ThemeManager.shared.color("text-tertiary"), in: RoundedRectangle(cornerRadius: CGFloat(2)))
                  }
                }
                .padding(.top, ThemeManager.shared.size("spacing-2"))
                .padding(.bottom, ThemeManager.shared.size("spacing-2"))
                ScrollView(.horizontal, showsIndicators: true) {
                VStack() {
                  // slot
                }
                }
                .frame(maxWidth: .infinity)
              }
              .specFrameHeight(specPx(vm.sheetHeight))
              .frame(maxHeight: CGFloat(0))
              .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.snapPoints, snapPoints) { vm.snapPoints = snapPoints }; if !specEq(vm.initialSnap, initialSnap) { vm.initialSnap = initialSnap }; if !specEq(vm.showHandle, showHandle) { vm.showHandle = showHandle }; if !specEq(vm.backdrop, backdrop) { vm.backdrop = backdrop } }
    .task(id: specPropsKey([open, snapPoints, initialSnap, showHandle, backdrop])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.snapPoints, snapPoints) { vm.snapPoints = snapPoints }; if !specEq(vm.initialSnap, initialSnap) { vm.initialSnap = initialSnap }; if !specEq(vm.showHandle, showHandle) { vm.showHandle = showHandle }; if !specEq(vm.backdrop, backdrop) { vm.backdrop = backdrop } }
  }
}
