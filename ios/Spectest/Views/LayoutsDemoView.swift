import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class LayoutsDemoViewModel {
  var activeLayout: Any = "auth-page"
  var settingsSection: Any = "profile"
  var dashNav: Any = "home"
  var showAuth: Any { specEq(activeLayout, "auth-page") }
  var showDashboard: Any { specEq(activeLayout, "dashboard") }
  var showLanding: Any { specEq(activeLayout, "landing") }
  var showSettings: Any { specEq(activeLayout, "settings-page") }
  var showSplit: Any { specEq(activeLayout, "split-view") }
  func setLayout(_ id: Any) {
    activeLayout = id
  }
  func setSettingsSection(_ id: Any) {
    settingsSection = id
  }
  func setDashNav(_ id: Any) {
    dashNav = id
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct LayoutsDemoView: View {
  @State private var vm = LayoutsDemoViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = LayoutsDemoViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("layout")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Layout Packages"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
      }

      Text(verbatim: specString("Curated page-level layouts from the spec-registry. Each layout composes existing components and works with all themes via design tokens."))
        .font(.body)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      ScrollView(.horizontal, showsIndicators: true) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
        ForEach(Array(specArr([["id": "auth-page" as Any, "label": "Auth Page" as Any] as [String: Any], ["id": "dashboard" as Any, "label": "Dashboard" as Any] as [String: Any], ["id": "landing" as Any, "label": "Landing" as Any] as [String: Any], ["id": "settings-page" as Any, "label": "Settings Page" as Any] as [String: Any], ["id": "split-view" as Any, "label": "Split View" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, tab in
          Button(action: { specClick { vm.setLayout(specGet(tab, "id")) } }) {
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString(specGet(tab, "label")))
              .font(.footnote.weight(.medium))
              .foregroundStyle((specEq(vm.activeLayout, specGet(tab, "id")) ? ThemeManager.shared.color("on-interactive") : ThemeManager.shared.color("text-primary")))
          }
          .padding(specBorderWidth((specEq(vm.activeLayout, specGet(tab, "id")) ? "none" : ThemeManager.shared.rawToken("borders-default"))))
          .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-3")))
          .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-3")))
          .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-2")))
          .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-2")))
          .background((specEq(vm.activeLayout, specGet(tab, "id")) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll((specEq(vm.activeLayout, specGet(tab, "id")) ? "none" : ThemeManager.shared.rawToken("borders-default")), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .hoverEffect(.highlight)
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
        }
      }
      }

      VStack(alignment: .leading, spacing: 0) {
        if (vm.showAuth) as? Bool ?? false {
          _specArm0
        }
        if (vm.showDashboard) as? Bool ?? false {
          _specArm1
        }
        if (vm.showLanding) as? Bool ?? false {
          _specArm2
        }
        if (vm.showSettings) as? Bool ?? false {
          _specArm3
        }
        if (vm.showSplit) as? Bool ?? false {
          _specArm4
        }
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .specFrameHeight(CGFloat(520), alignment: .top)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("background"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-lg")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .center, spacing: 0) {
          Spacer(minLength: 0)
          VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
            HStack(alignment: .center, spacing: 0) {
              Spacer(minLength: 0)
              Image(systemName: specIconName(specString("lock")))
                .font(.system(size: specPx(24)))
                .foregroundStyle(ThemeManager.shared.color("on-interactive"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .frame(width: CGFloat(48), alignment: .center)
            .specFrameHeight(CGFloat(48), alignment: .center)
            .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              Text(verbatim: specString("Sign In"))
                .font(.largeTitle)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Welcome back! Enter your credentials."))
                .font(.body)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                SpecTextField(specString("you@example.com"), text: .constant(specString("")))
                .textFieldStyle(.roundedBorder)
                .specAccessibilityLabel(specFieldName("", "Email"))
              }
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Password")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                SpecTextField(specString("Enter password"), text: .constant(specString("")))
                .textFieldStyle(.roundedBorder)
                .specAccessibilityLabel(specFieldName("", "Password"))
              }
              Button(action: {  }) {
                Text(specString("Sign In"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .frame(maxWidth: .infinity)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFullBasis()
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Spacer(minLength: 0)
              Text(verbatim: specString("Forgot password?"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              Text(verbatim: specString("·"))
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
              Text(verbatim: specString("Create account"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-3")))
            .frame(maxWidth: .infinity, alignment: .center)
            .specBorderSides(nil, top: ThemeManager.shared.rawToken("borders-default"), right: nil, bottom: nil, left: nil, radius: CGFloat(0))
            .specFullBasis()
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-6")))
          .frame(maxWidth: .infinity, alignment: .center)
          .frame(maxWidth: CGFloat(420), alignment: .center)
          .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-lg")))
          .specBoxShadow(ThemeManager.shared.rawToken("elevation-layered"), radius: specPx(ThemeManager.shared.rawToken("radius-lg")))
          .specFullBasis()
          Spacer(minLength: 0)
        }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(maxHeight: .infinity, alignment: .center)
        .background(ThemeManager.shared.color("background"))
        .specFullBasis()
    })
  }

  private var _specArm1: AnyView {
    AnyView(Group {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Image(systemName: specIconName(specString("home")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              Text(verbatim: specString("Acme App"))
                .font(.largeTitle)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }

            Spacer(minLength: 0)
            Button(action: {  }) {
              Text(specString("Notifications"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
          }
          .frame(maxWidth: .infinity)
          .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(.leading, CGFloat(16))
          .padding(.trailing, CGFloat(16))
          .padding(.top, CGFloat(8))
          .padding(.bottom, CGFloat(8))
          .frame(maxWidth: .infinity, alignment: .center)
          .background(ThemeManager.shared.color("surface"))
          .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
          .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"))
          HStack(alignment: .center, spacing: 0) {
            ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              Text(verbatim: specString("MAIN"))
                .font(.caption2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                .textCase(.uppercase)
              ForEach(Array(specArr([["id": "home" as Any, "label": "Home" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "users" as Any, "label": "Users" as Any, "icon": "user" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, item in
                Button(action: { specClick { vm.setDashNav(specGet(item, "id")) } }) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                  Group {
                    if !specString(specGet(item, "icon")).trimmingCharacters(in: .whitespaces).isEmpty {
                      Image(systemName: specIconName(specString(specGet(item, "icon"))))
                        .font(.system(size: specPx(18)))
                        .foregroundStyle((specEq(specGet(item, "id"), vm.dashNav) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-secondary")))
                    }
                  }
                  Text(verbatim: specString(specGet(item, "label")))
                    .font(.body)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                    .foregroundStyle((specEq(specGet(item, "id"), vm.dashNav) ? ThemeManager.shared.color("text-primary") : ThemeManager.shared.color("text-secondary")))
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
                .frame(maxWidth: .infinity, alignment: .center)
                .background((specEq(specGet(item, "id"), vm.dashNav) ? ThemeManager.shared.color("surface-raised") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .hoverEffect(.highlight)
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
              }
              VStack(alignment: .leading, spacing: 0) {
              }
              .specFrameHeight(specPx(ThemeManager.shared.rawToken("spacing-3")))
              Text(verbatim: specString("SYSTEM"))
                .font(.caption2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                .textCase(.uppercase)
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Image(systemName: specIconName(specString("settings")))
                  .font(.system(size: specPx(18)))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString("Settings"))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
              .frame(maxWidth: .infinity, alignment: .center)
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .hoverEffect(.highlight)
            }
            }
            .padding(.trailing, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
            .frame(width: CGFloat(200), alignment: .leading)
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(minWidth: CGFloat(200), alignment: .leading)
            .background(ThemeManager.shared.color("surface"))
            .specBorderSides(nil, top: nil, right: ThemeManager.shared.rawToken("borders-default"), bottom: nil, left: nil, radius: CGFloat(0))
            ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              Text(verbatim: specString("Dashboard Home"))
                .font(.title)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("This is the main content area. The sidebar handles navigation."))
                .font(.body)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
                ForEach(Array(specArr([["label": "Users" as Any, "value": "1,284" as Any] as [String: Any], ["label": "Revenue" as Any, "value": "$42.5k" as Any] as [String: Any], ["label": "Orders" as Any, "value": "856" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, stat in
                  VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                      Text(verbatim: specString(specGet(stat, "label")))
                        .font(.footnote)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                      Text(verbatim: specString(specGet(stat, "value")))
                        .font(.largeTitle)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    }
                    .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
                  }
                  .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                }
              }

            }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("surface"))
            .specFlexGrow(1)
          }
          .frame(maxHeight: .infinity, alignment: .leading)
          .clipped()
          .specFlexGrow(1)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeManager.shared.color("background"))
        .clipped()
    })
  }

  private var _specArm2: AnyView {
    AnyView(Group {
        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: 0) {
            Text(verbatim: specString("SpecLang"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Spacer(minLength: 0)
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Button(action: {  }) {
                Text(specString("Docs"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
              }
              Button(action: {  }) {
                Text(specString("Get Started"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
              }
            }

          }
          .frame(maxWidth: .infinity)
          .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-3")))
          .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-3")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface"))
          .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
          .specFullBasis()
          VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Text(verbatim: specString("Build UIs with Spec"))
                .font(.largeTitle)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-xl-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("A declarative language that compiles to minimal, dependency-free JavaScript."))
                .font(.title3)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-lg-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .frame(maxWidth: CGFloat(700), alignment: .center)
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Button(action: {  }) {
                Text(specString("Get Started"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("View on GitHub"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }

          }
          .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-8")))
          .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-8")))
          .frame(maxWidth: .infinity, alignment: .center)
          .background(ThemeManager.shared.color("surface"))
          .specFullBasis()
          VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Text(verbatim: specString("Features"))
                .font(.largeTitle)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString("Everything you need to build fast."))
                .font(.title3)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-lg-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              ForEach(Array(specArr([["title": "Declarative" as Any, "desc": "Write what you want, not how to render it." as Any] as [String: Any], ["title": "Tiny Output" as Any, "desc": "~2 KB runtime. Zero dependencies." as Any] as [String: Any], ["title": "Theme-able" as Any, "desc": "Design tokens power every component." as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, feat in
                VStack(alignment: .leading) {
                  VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                    Text(verbatim: specString(specGet(feat, "title")))
                      .font(.title2)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Text(verbatim: specString(specGet(feat, "desc")))
                      .font(.body)
                      .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                      .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  }
                  .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
                }
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxWidth: CGFloat(900), alignment: .leading)
            .specFullBasis()
          }
          .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-7")))
          .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-7")))
          .frame(maxWidth: .infinity, alignment: .center)
          .specFullBasis()
          HStack(alignment: .center, spacing: 0) {
            Text(verbatim: specString("© 2026 Spec Project"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            Spacer(minLength: 0)
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Text(verbatim: specString("Docs"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("GitHub"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Community"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

          }
          .frame(maxWidth: .infinity)
          .padding(.top, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(.leading, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.trailing, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-5")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface"))
          .specBorderSides(nil, top: ThemeManager.shared.rawToken("borders-default"), right: nil, bottom: nil, left: nil, radius: CGFloat(0))
          .specFullBasis()
        }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeManager.shared.color("background"))
    })
  }

  private var _specArm3: AnyView {
    AnyView(Group {
        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Image(systemName: specIconName(specString("settings")))
              .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Settings"))
              .font(.largeTitle)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
          }

          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              ForEach(Array(specArr([["id": "profile" as Any, "label": "Profile" as Any, "icon": "user" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any], ["id": "security" as Any, "label": "Security" as Any, "icon": "lock" as Any] as [String: Any], ["id": "billing" as Any, "label": "Billing" as Any, "icon": "credit-card" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, sec in
                Button(action: { specClick { vm.setSettingsSection(specGet(sec, "id")) } }) {
                HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                  Group {
                    if !specString(specGet(sec, "icon")).trimmingCharacters(in: .whitespaces).isEmpty {
                      Image(systemName: specIconName(specString(specGet(sec, "icon"))))
                        .font(.system(size: specPx(18)))
                        .foregroundStyle((specEq(specGet(sec, "id"), vm.settingsSection) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-secondary")))
                    }
                  }
                  Text(verbatim: specString(specGet(sec, "label")))
                    .font(.body)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                    .foregroundStyle((specEq(specGet(sec, "id"), vm.settingsSection) ? ThemeManager.shared.color("text-primary") : ThemeManager.shared.color("text-secondary")))
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
                .frame(maxWidth: .infinity, alignment: .center)
                .background((specEq(specGet(sec, "id"), vm.settingsSection) ? ThemeManager.shared.color("surface") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .specBoxShadow((specEq(specGet(sec, "id"), vm.settingsSection) ? ThemeManager.shared.rawToken("elevation-raised") : ThemeManager.shared.rawToken("elevation-flat")), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                .hoverEffect(.highlight)
                  .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
              }
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
            .frame(width: CGFloat(200), alignment: .leading)
            .frame(minWidth: CGFloat(200), alignment: .leading)
            .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-lg")))
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              if specEq(vm.settingsSection, "profile") {
              VStack(alignment: .leading, spacing: 0) {
                if specEq(vm.settingsSection, "profile") {
                  VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
                      Text(verbatim: specString("Profile"))
                        .font(.title)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-primary"))
                      VStack(alignment: .leading, spacing: 4) {
                        Text(specString("Display Name")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                        SpecTextField(specString("Your name"), text: .constant(specString("Jane Doe")))
                        .textFieldStyle(.roundedBorder)
                        .specAccessibilityLabel(specFieldName("", "Display Name"))
                      }
                      VStack(alignment: .leading, spacing: 4) {
                        Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                        SpecTextField(specString("Email"), text: .constant(specString("jane@example.com")))
                        .textFieldStyle(.roundedBorder)
                        .specAccessibilityLabel(specFieldName("", "Email"))
                      }
                    }
                    .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
                  }
                  .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                }
              }

              }
              if specEq(vm.settingsSection, "notifications") {
              VStack(alignment: .leading, spacing: 0) {
                if specEq(vm.settingsSection, "notifications") {
                  VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
                      Text(verbatim: specString("Notifications"))
                        .font(.title)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-primary"))
                      Toggle(specString("Email notifications"), isOn: .constant(specTruthy(true)))
                      Toggle(specString("Push notifications"), isOn: .constant(specTruthy(false)))
                    }
                    .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
                  }
                  .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                }
              }

              }
              if specEq(vm.settingsSection, "security") {
              VStack(alignment: .leading, spacing: 0) {
                if specEq(vm.settingsSection, "security") {
                  VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
                      Text(verbatim: specString("Security"))
                        .font(.title)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-primary"))
                      Text(verbatim: specString("Two-factor authentication is enabled."))
                        .font(.body)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                      Button(action: {  }) {
                        Text(specString("Change Password"))
                          .lineLimit(1)
                          .fixedSize(horizontal: true, vertical: false)
                          .font(.subheadline.weight(.medium))
                          .foregroundStyle(ThemeManager.shared.color("interactive"))
                          .frame(maxWidth: .infinity)
                          .padding(.horizontal, 16)
                          .padding(.vertical, 8)
                          .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                      }
                    }
                    .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
                  }
                  .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                }
              }

              }
              if specEq(vm.settingsSection, "billing") {
              VStack(alignment: .leading, spacing: 0) {
                if specEq(vm.settingsSection, "billing") {
                  VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
                      Text(verbatim: specString("Billing"))
                        .font(.title)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-primary"))
                      Text(verbatim: specString("Current plan: Pro"))
                        .font(.body)
                        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                      Button(action: {  }) {
                        Text(specString("Manage Subscription"))
                          .lineLimit(1)
                          .fixedSize(horizontal: true, vertical: false)
                          .font(.subheadline.weight(.semibold))
                          .foregroundStyle(.white)
                          .frame(maxWidth: .infinity)
                          .padding(.horizontal, 16)
                          .padding(.vertical, 8)
                          .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
                      }
                    }
                    .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
                  }
                  .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                }
              }

              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFlexGrow(1)
          }
          .frame(maxHeight: .infinity, alignment: .leading)
          .specFlexGrow(1)
        }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .frame(maxHeight: .infinity, alignment: .top)
    })
  }

  private var _specArm4: AnyView {
    AnyView(Group {
        HStack(alignment: .center, spacing: 0) {
          ScrollView(.vertical, showsIndicators: true) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Text(verbatim: specString("Files"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            ForEach(Array(specArr([["name": "app.spec" as Any] as [String: Any], ["name": "settings.spec" as Any] as [String: Any], ["name": "theme.spec" as Any] as [String: Any], ["name": "utils.spec" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, file in
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Image(systemName: specIconName(specString("file")))
                  .font(.system(size: specPx(16)))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString(specGet(file, "name")))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
              .frame(maxWidth: .infinity, alignment: .center)
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .hoverEffect(.highlight)
            }
          }
          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(width: CGFloat(240), alignment: .leading)
          .frame(maxHeight: .infinity, alignment: .top)
          .frame(minWidth: CGFloat(240), alignment: .leading)
          .background(ThemeManager.shared.color("surface"))
          HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
            }
            .frame(width: CGFloat(2))
            .specFrameHeight(CGFloat(24))
            .background(ThemeManager.shared.color("text-tertiary"), in: RoundedRectangle(cornerRadius: CGFloat(1)))
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(1)))
            .opacity(CGFloat(0.5))
          }
          .frame(width: CGFloat(6), alignment: .center)
          .frame(maxHeight: .infinity, alignment: .center)
          .frame(minWidth: CGFloat(6), alignment: .center)
          .background(ThemeManager.shared.color("border"))
          .hoverEffect(.highlight)
          ScrollView(.vertical, showsIndicators: true) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Text(verbatim: specString("Editor"))
              .font(.title2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("Select a file from the left panel to begin editing."))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("surface App { ... }"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          }
          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
          .frame(maxHeight: .infinity, alignment: .top)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface"))
          .specFlexGrow(1)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .clipped()
    })
  }
}
