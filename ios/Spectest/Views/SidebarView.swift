import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class SidebarViewModel {
  var activeItem: Any = ""
  var collapsed: Any = false
  var collapsedWidth: Any = "56px"
  var sections: Any? = nil
  var width: Any = "240px"
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct SidebarView: View {
  @State private var vm = SidebarViewModel()
  var activeItem: Any = ""
  var collapsed: Any = false
  var collapsedWidth: Any = "56px"
  var sections: Any? = nil
  var width: Any = "240px"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(activeItem: Any = "", collapsed: Any = false, collapsedWidth: Any = "56px", sections: Any? = nil, width: Any = "240px", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = SidebarViewModel(); _m.activeItem = activeItem; _m.collapsed = collapsed; _m.collapsedWidth = collapsedWidth; _m.sections = sections; _m.width = width; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.activeItem = activeItem; self.collapsed = collapsed; self.collapsedWidth = collapsedWidth; self.sections = sections; self.width = width; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(activeItem) + "\u{1}" + specChangeKey(collapsed) + "\u{1}" + specChangeKey(collapsedWidth) + "\u{1}" + specChangeKey(sections) + "\u{1}" + specChangeKey(width) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        if specEq(vm.collapsed, true) {
        HStack(alignment: .center, spacing: 0) {
          Spacer(minLength: 0)
          Button(action: { specClick { vm.dispatch("collapse", [false] as [Any]) } }) {
          HStack(alignment: .center, spacing: 0) {
            Text(verbatim: specString("»"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .frame(width: CGFloat(32), alignment: .center)
          .specFrameHeight(CGFloat(32), alignment: .center)
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .hoverEffect(.highlight)
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
        }
        if specEq(vm.collapsed, false) {
        HStack(alignment: .center, spacing: 0) {
          Spacer(minLength: 0)
          Button(action: { specClick { vm.dispatch("collapse", [true] as [Any]) } }) {
          HStack(alignment: .center, spacing: 0) {
            Text(verbatim: specString("«"))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .frame(width: CGFloat(32), alignment: .center)
          .specFrameHeight(CGFloat(32), alignment: .center)
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .hoverEffect(.highlight)
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
        }
        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
          ForEach(Array(specArr(vm.sections).enumerated()), id: \.offset) { _idx, section in
            if (specEq(vm.collapsed, false) && !specIsNil(specGet(section, "title"))) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString(specGet(section, "title")))
                .font(.caption2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                .textCase(.uppercase)
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
            .opacity(specPx((specEq(vm.collapsed, false) ? 1 : 0)))
            }
            ForEach(Array(specArr(specGet(section, "items")).enumerated()), id: \.offset) { _idx, item in
              Button(action: { specClick { vm.dispatch("select", [specGet(item, "id")] as [Any]) } }) {
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                HStack(alignment: .center, spacing: 0) {
                  Group {
                    if !specString((!specIsNil(specGet(item, "icon")) ? specGet(item, "icon") : "circle")).trimmingCharacters(in: .whitespaces).isEmpty {
                      Image(systemName: specIconName(specString((!specIsNil(specGet(item, "icon")) ? specGet(item, "icon") : "circle"))))
                        .font(.system(size: specPx(18)))
                        .foregroundStyle((specEq(specGet(item, "id"), vm.activeItem) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-secondary")))
                    }
                  }
                }
                .frame(width: CGFloat(24), alignment: .center)
                .specFrameHeight(CGFloat(24), alignment: .center)
                .frame(minWidth: CGFloat(24), alignment: .center)
                if specEq(vm.collapsed, false) {
                VStack(alignment: .leading, spacing: 0) {
                  Text(verbatim: specString(specGet(item, "label")))
                    .font(.body)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                    .foregroundStyle((specEq(specGet(item, "id"), vm.activeItem) ? ThemeManager.shared.color("text-primary") : ThemeManager.shared.color("text-secondary")))
                }
                .opacity(specPx((specEq(vm.collapsed, false) ? 1 : 0)))
                }
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
              .frame(maxWidth: .infinity, alignment: .center)
              .background((specEq(specGet(item, "id"), vm.activeItem) ? ThemeManager.shared.color("surface-raised") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .hoverEffect(.highlight)
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }
          }
        }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
        .frame(maxHeight: .infinity, alignment: .leading)
        .specFlexGrow(1)
      }
      .padding(.trailing, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .specFrameWidth(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width), alignment: .leading)
      .frame(maxHeight: .infinity, alignment: .top)
      .frame(minWidth: specPx(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)), alignment: .leading)
      .background(ThemeManager.shared.color("surface"))
      .clipped()
      .specBorderSides(nil, top: nil, right: ThemeManager.shared.rawToken("borders-default"), bottom: nil, left: nil, radius: CGFloat(0))
      .accessibilityElement(children: .contain)
      .accessibilityLabel(specString("Sidebar navigation"))
      .specFullBasis(specString(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)) == "100%")
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .specFullBasis(specString(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)) == "100%")
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.activeItem = activeItem
      vm.collapsed = collapsed
      vm.collapsedWidth = collapsedWidth
      vm.sections = sections
      vm.width = width
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.sections, sections) { vm.sections = sections }; if !specSame(vm.activeItem, activeItem) { vm.activeItem = activeItem }; if !specSame(vm.collapsed, collapsed) { vm.collapsed = collapsed }; if !specSame(vm.width, width) { vm.width = width }; if !specSame(vm.collapsedWidth, collapsedWidth) { vm.collapsedWidth = collapsedWidth } }
    .task(id: specPropsKey([sections, activeItem, collapsed, width, collapsedWidth])) { if !specSame(vm.sections, sections) { vm.sections = sections }; if !specSame(vm.activeItem, activeItem) { vm.activeItem = activeItem }; if !specSame(vm.collapsed, collapsed) { vm.collapsed = collapsed }; if !specSame(vm.width, width) { vm.width = width }; if !specSame(vm.collapsedWidth, collapsedWidth) { vm.collapsedWidth = collapsedWidth } }
  }
}
