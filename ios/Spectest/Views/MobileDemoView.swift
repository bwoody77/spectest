import SwiftUI
import SpecRuntime

@Observable
final class MobileDemoViewModel {
  var api: Any? = nil
  var activeTab: Any = "home"
  var sheetOpen: Any = false
  var actionSheetOpen: Any = false
  var snackbarOpen: Any = false
  var items: Any = [["id": "1" as Any, "title": "Welcome to Mobile" as Any, "subtitle": "Swipe, scroll, and tap" as Any] as [String: Any], ["id": "2" as Any, "title": "Gesture Support" as Any, "subtitle": "Swipe left/right, drag, long-press" as Any] as [String: Any], ["id": "3" as Any, "title": "Bottom Sheet" as Any, "subtitle": "Tap to open the bottom sheet" as Any] as [String: Any], ["id": "4" as Any, "title": "Safe Areas" as Any, "subtitle": "Proper insets on all devices" as Any] as [String: Any], ["id": "5" as Any, "title": "Scroll Snapping" as Any, "subtitle": "Smooth carousel experience" as Any] as [String: Any]] as [Any]
  var loadingMore: Any = false
  var hasMoreItems: Any = true
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func onTabChange(_ tabId: Any) {
    activeTab = tabId
  }
  func openSheet() {
    sheetOpen = true
  }
  func closeSheet() {
    sheetOpen = false
  }
  func openActionSheet() {
    actionSheetOpen = true
  }
  func closeActionSheet() {
    actionSheetOpen = false
  }
  func showSnackbar() {
    snackbarOpen = true
  }
  func closeSnackbar() {
    snackbarOpen = false
  }
  func loadMore() {
    loadingMore = true
  }
  func handleSwipeLeft() {
    showSnackbar()
  }
  func handleSwipeRight() {
    openSheet()
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct MobileDemoView: View {
  @State private var vm = MobileDemoViewModel()
  var api: Any? = nil
  init(api: Any? = nil) { self._vm = State(initialValue: MobileDemoViewModel()); self.api = api }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
          Text(verbatim: specString("Mobile Demo"))
            .font(.title2.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("Gesture events, bottom sheet, safe areas"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        }
        .padding(ThemeManager.shared.size("spacing-4"))
        .background(ThemeManager.shared.color("surface"))
        .background(ThemeManager.shared.color("surface"))
        ScrollView(.horizontal, showsIndicators: true) {
        VStack(spacing: CGFloat(16)) {
          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Swipe Zone"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Swipe left for snackbar, right for bottom sheet"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(ThemeManager.shared.size("spacing-5"))
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Scroll Snap Carousel"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            ScrollView(.horizontal, showsIndicators: true) {
            HStack(alignment: .center, spacing: CGFloat(16)) {
              ForEach(Array(specArr(vm.items).enumerated()), id: \.offset) { _idx, item in
                VStack() {
                  Text(verbatim: specString(specGet(item, "title")))
                    .font(.headline.bold())
                    .foregroundStyle(Color.white)
                  Text(verbatim: specString(specGet(item, "subtitle")))
                    .font(.callout.bold())
                    .foregroundStyle(Color(.sRGB, red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.8))
                }
                .padding(ThemeManager.shared.size("spacing-5"))
                .frame(minWidth: CGFloat(280))
                .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
              }
            }
            }

          }

          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Components"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            HStack(alignment: .center, spacing: CGFloat(8)) {
              Button(action: { vm.openSheet() }) {
              VStack() {
                Text(verbatim: specString("Bottom Sheet"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, ThemeManager.shared.size("spacing-4"))
              .padding(.trailing, ThemeManager.shared.size("spacing-4"))
              .padding(.top, ThemeManager.shared.size("spacing-2"))
              .padding(.bottom, ThemeManager.shared.size("spacing-2"))
              .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              }
              .buttonStyle(.plain)
              Button(action: { vm.openActionSheet() }) {
              VStack() {
                Text(verbatim: specString("Action Sheet"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, ThemeManager.shared.size("spacing-4"))
              .padding(.trailing, ThemeManager.shared.size("spacing-4"))
              .padding(.top, ThemeManager.shared.size("spacing-2"))
              .padding(.bottom, ThemeManager.shared.size("spacing-2"))
              .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              }
              .buttonStyle(.plain)
              Button(action: { vm.showSnackbar() }) {
              VStack() {
                Text(verbatim: specString("Snackbar"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, ThemeManager.shared.size("spacing-4"))
              .padding(.trailing, ThemeManager.shared.size("spacing-4"))
              .padding(.top, ThemeManager.shared.size("spacing-2"))
              .padding(.bottom, ThemeManager.shared.size("spacing-2"))
              .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              }
              .buttonStyle(.plain)
            }

          }

          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Long Press"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Long press this card to open the action sheet"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(ThemeManager.shared.size("spacing-5"))
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
          VStack() {
            Text(verbatim: specString("Visibility Trigger"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Snackbar shown when this card scrolled into view"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(ThemeManager.shared.size("spacing-5"))
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
        }
        }
        .padding(ThemeManager.shared.size("spacing-4"))
        .padding(.bottom, CGFloat(80))
        .frame(maxWidth: .infinity)
        BottomTabBarView(activeTab: vm.activeTab, tabs: [["id": "home" as Any, "label": "Home" as Any, "icon": "home" as Any] as [String: Any], ["id": "search" as Any, "label": "Search" as Any, "icon": "search" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any], ["id": "user" as Any, "label": "Profile" as Any, "icon": "user" as Any] as [String: Any]] as [Any])
        BottomSheetView(open: vm.sheetOpen)
        ActionSheetView(actions: [["id": "share" as Any, "label": "Share" as Any] as [String: Any], ["id": "copy" as Any, "label": "Copy Link" as Any] as [String: Any], ["id": "edit" as Any, "label": "Edit" as Any] as [String: Any], ["id": "delete" as Any, "label": "Delete" as Any, "destructive": true as Any] as [String: Any]] as [Any], open: vm.actionSheetOpen, title: "Choose an action")
        if vm.snackbarOpen as? Bool ?? false {
          HStack(spacing: 8) {
            Image(systemName: specAlertIcon(specString("info")))
              .foregroundStyle(specAlertColor(specString("info")))
            Text(specString("Action completed successfully")).font(.subheadline)
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
          .shadow(radius: 4)
          .transition(.move(edge: .top).combined(with: .opacity))
        }
        FABView(icon: "plus")
      }
      .background(ThemeManager.shared.color("surface"))
      .frame(maxWidth: .infinity)
      .background(ThemeManager.shared.color("surface"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.api, api) { vm.api = api } }
    .task(id: specPropsKey([api])) { if !specEq(vm.api, api) { vm.api = api } }
  }
}
