import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct MobileDemoView: View {
  @State private var vm = MobileDemoViewModel()
  var api: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(api: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = MobileDemoViewModel(); _m.api = api; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.api = api; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(api) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Mobile Demo"))
            .font(.largeTitle)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("Gesture events, bottom sheet, safe areas"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        }
        .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeManager.shared.color("surface"))
        .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: CGFloat(16)) {
          VStack(alignment: .leading, spacing: CGFloat(8)) {
            Text(verbatim: specString("Swipe Zone"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Swipe left for snackbar, right for bottom sheet"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          VStack(alignment: .leading, spacing: CGFloat(8)) {
            Text(verbatim: specString("Scroll Snap Carousel"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            ScrollView(.horizontal, showsIndicators: true) {
            HStack(alignment: .center, spacing: CGFloat(16)) {
              ForEach(Array(specArr(vm.items).enumerated()), id: \.offset) { _idx, item in
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString(specGet(item, "title")))
                    .font(.title2)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                    .foregroundStyle(Color.white)
                  Text(verbatim: specString(specGet(item, "subtitle")))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                    .foregroundStyle(Color(.sRGB, red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.8))
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
                .frame(minWidth: CGFloat(280), alignment: .leading)
                .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
              }
            }
            }

          }

          VStack(alignment: .leading, spacing: CGFloat(8)) {
            Text(verbatim: specString("Components"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            HStack(alignment: .center, spacing: CGFloat(8)) {
              Button(action: { specClick { vm.openSheet() } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Bottom Sheet"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-4")))
              .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-4")))
              .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
              Button(action: { specClick { vm.openActionSheet() } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Action Sheet"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-4")))
              .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-4")))
              .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
              Button(action: { specClick { vm.showSnackbar() } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Snackbar"))
                  .font(.body)
                  .foregroundStyle(Color.white)
              }
              .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-4")))
              .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-4")))
              .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-2")))
              .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }

          }

          VStack(alignment: .leading, spacing: CGFloat(8)) {
            Text(verbatim: specString("Long Press"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Long press this card to open the action sheet"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString("Visibility Trigger"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Snackbar shown when this card scrolled into view"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          .onAppear { Task { @MainActor in await vm.showSnackbar() } }
        }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        .padding(.bottom, CGFloat(80))
        .frame(maxHeight: .infinity, alignment: .leading)
        .specFlexGrow(1)
        BottomTabBarView(activeTab: vm.activeTab, tabs: [["id": "home" as Any, "label": "Home" as Any, "icon": "home" as Any] as [String: Any], ["id": "search" as Any, "label": "Search" as Any, "icon": "search" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any], ["id": "user" as Any, "label": "Profile" as Any, "icon": "user" as Any] as [String: Any]] as [Any], onDispatch: { specEvent, specPayload in
          _ = specPayload
          switch specString(specEvent) {
          case "tabChange":
            let specArgs = specArr(specPayload)
            let tabId: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
            vm.onTabChange(tabId)
          default: break
          }
        })
        BottomSheetView(open: vm.sheetOpen, onDispatch: { specEvent, specPayload in
          _ = specPayload
          switch specString(specEvent) {
          case "close":
            vm.closeSheet()
          default: break
          }
        }, specChildren: AnyView(Group {
            VStack(alignment: .leading, spacing: CGFloat(12)) {
              Text(verbatim: specString("Bottom Sheet"))
                .font(.title)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("This sheet slides up from the bottom. You can drag the handle to resize or dismiss it."))
                .font(.body)
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          }))
        ActionSheetView(actions: [["id": "share" as Any, "label": "Share" as Any] as [String: Any], ["id": "copy" as Any, "label": "Copy Link" as Any] as [String: Any], ["id": "edit" as Any, "label": "Edit" as Any] as [String: Any], ["id": "delete" as Any, "label": "Delete" as Any, "destructive": true as Any] as [String: Any]] as [Any], open: vm.actionSheetOpen, title: "Choose an action", onDispatch: { specEvent, specPayload in
          _ = specPayload
          switch specString(specEvent) {
          case "close":
            vm.closeActionSheet()
          case "select":
            let specArgs = specArr(specPayload)
            let actionId: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
            vm.closeActionSheet()
          default: break
          }
        })
        if vm.snackbarOpen as? Bool ?? false {
          SpecSnackbar(message: specString("Action completed successfully"), actionLabel: specString("Undo"), duration: 4000,
            onAction: { vm.closeSnackbar() },
            onClose: { vm.snackbarOpen = false; vm.closeSnackbar() })
        }
        FABView(icon: "plus", onDispatch: { specEvent, specPayload in
          _ = specPayload
          switch specString(specEvent) {
          case "click":
            vm.openSheet()
          default: break
          }
        })
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(minHeight: CGFloat(UIScreen.main.bounds.height * 1), alignment: .top)
      .background(ThemeManager.shared.color("surface"))
      .specFullBasis()
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.api = api
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.api, api) { vm.api = api } }
    .task(id: specPropsKey([api])) { if !specSame(vm.api, api) { vm.api = api } }
  }
}
