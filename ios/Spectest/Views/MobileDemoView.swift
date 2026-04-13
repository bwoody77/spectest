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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Text(verbatim: specString("Gesture events, bottom sheet, safe areas"))
            .font(.callout.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        }
        .padding(CGFloat(16))
        .padding(.top, CGFloat(0))
        .background(ThemeManager.shared.color("semantic.surface"))
        .background(ThemeManager.shared.color("semantic.surface"))
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
        VStack(spacing: CGFloat(16)) {
          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Swipe Zone"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("Swipe left for snackbar, right for bottom sheet"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
          .padding(CGFloat(20))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Scroll Snap Carousel"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            ScrollView([.horizontal, .vertical], showsIndicators: true) {
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
                .padding(CGFloat(20))
                .frame(minWidth: CGFloat(280))
                .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
              }
            }
            }

          }

          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Components"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            HStack(alignment: .center, spacing: CGFloat(8)) {
              VStack() {
                Text(verbatim: specString("Bottom Sheet"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, CGFloat(16))
              .padding(.trailing, CGFloat(16))
              .padding(.top, CGFloat(8))
              .padding(.bottom, CGFloat(8))
              .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .onTapGesture { vm.openSheet() }
              VStack() {
                Text(verbatim: specString("Action Sheet"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, CGFloat(16))
              .padding(.trailing, CGFloat(16))
              .padding(.top, CGFloat(8))
              .padding(.bottom, CGFloat(8))
              .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .onTapGesture { vm.openActionSheet() }
              VStack() {
                Text(verbatim: specString("Snackbar"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, CGFloat(16))
              .padding(.trailing, CGFloat(16))
              .padding(.top, CGFloat(8))
              .padding(.bottom, CGFloat(8))
              .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .onTapGesture { vm.showSnackbar() }
            }

          }

          VStack(spacing: CGFloat(8)) {
            Text(verbatim: specString("Long Press"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("Long press this card to open the action sheet"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
          .padding(CGFloat(20))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
          VStack() {
            Text(verbatim: specString("Visibility Trigger"))
              .font(.headline.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString("Snackbar shown when this card scrolled into view"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
          .padding(CGFloat(20))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
        }
        }
        .padding(CGFloat(16))
        .padding(.bottom, CGFloat(80))
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
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
      .background(ThemeManager.shared.color("semantic.surface"))
      .frame(maxWidth: .infinity)
      .frame(minHeight: CGFloat(0))
      .background(ThemeManager.shared.color("semantic.surface"))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.api, api) { vm.api = api } }
    .task(id: specPropsKey([api])) { if !specEq(vm.api, api) { vm.api = api } }
  }
}
