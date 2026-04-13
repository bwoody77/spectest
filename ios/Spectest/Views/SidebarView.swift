import SwiftUI
import SpecRuntime

@Observable
final class SidebarViewModel {
  var activeItem: Any = ""
  var collapsed: Any = false
  var collapsedWidth: Any = "56px"
  var sections: Any? = nil
  var width: Any = "240px"
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct SidebarView: View {
  @State private var vm = SidebarViewModel()
  var activeItem: Any = ""
  var collapsed: Any = false
  var collapsedWidth: Any = "56px"
  var sections: Any? = nil
  var width: Any = "240px"
  init(activeItem: Any = "", collapsed: Any = false, collapsedWidth: Any = "56px", sections: Any? = nil, width: Any = "240px") { self._vm = State(initialValue: SidebarViewModel()); self.activeItem = activeItem; self.collapsed = collapsed; self.collapsedWidth = collapsedWidth; self.sections = sections; self.width = width }
  var body: some View {
    VStack() {
      VStack() {
        HStack(alignment: .center, ) {
          if specEq(vm.collapsed, true) {
            HStack(alignment: .center, ) {
              Text(verbatim: specString("u00BB"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .frame(width: CGFloat(32))
            .frame(height: CGFloat(32))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { /* event callback */ }
          }
        }
        .padding(CGFloat(8))
        HStack(alignment: .center, ) {
          if specEq(vm.collapsed, false) {
            HStack(alignment: .center, ) {
              Text(verbatim: specString("u00AB"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .frame(width: CGFloat(32))
            .frame(height: CGFloat(32))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { /* event callback */ }
          }
        }
        .padding(CGFloat(8))
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
        VStack(spacing: CGFloat(4)) {
          ForEach(Array(specArr(vm.sections).enumerated()), id: \.offset) { _idx, section in
            VStack() {
              if (specEq(vm.collapsed, false) && specGet(section, "title") != nil) {
                Text(verbatim: specString(specGet(section, "title")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              }
            }
            .padding(CGFloat(8))
            .opacity(specPx((specEq(vm.collapsed, false) ? 1 : 0)))
            ForEach(Array(specArr(specGet(section, "items")).enumerated()), id: \.offset) { _idx, item in
              HStack(alignment: .center, spacing: CGFloat(8)) {
                HStack(alignment: .center, ) {
                  Image(systemName: specIconName(specString((specGet(item, "icon") != nil ? specGet(item, "icon") : "circle"))))
                    .font(.system(size: specPx(18)))
                    .foregroundStyle(Color(hex: (specEq(specGet(item, "id"), vm.activeItem) ? "#1677ff" : "#496183") as? String ?? "#000"))
                }
                .frame(width: CGFloat(24))
                .frame(height: CGFloat(24))
                .frame(minWidth: CGFloat(24))
                VStack() {
                  if specEq(vm.collapsed, false) {
                    Text(verbatim: specString(specGet(item, "label")))
                      .font(.body.bold())
                      .foregroundStyle(Color(hex: (specEq(specGet(item, "id"), vm.activeItem) ? "#202732" : "#496183") as? String ?? "#000"))
                  }
                }
                .opacity(specPx((specEq(vm.collapsed, false) ? 1 : 0)))
              }
              .padding(CGFloat(8))
              .background(Color(hex: (specEq(specGet(item, "id"), vm.activeItem) ? "#ffffff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              .onTapGesture { /* event callback */ }
            }
          }
        }
        }
        .padding(CGFloat(8))
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
      }
      .background(ThemeManager.shared.color("semantic.surface"))
      .frame(width: specPx(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)))
      .frame(maxHeight: .infinity)
      .frame(minWidth: specPx(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)))
      .background(ThemeManager.shared.color("semantic.surface"))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.sections, sections) { vm.sections = sections }; if !specEq(vm.activeItem, activeItem) { vm.activeItem = activeItem }; if !specEq(vm.collapsed, collapsed) { vm.collapsed = collapsed }; if !specEq(vm.width, width) { vm.width = width }; if !specEq(vm.collapsedWidth, collapsedWidth) { vm.collapsedWidth = collapsedWidth } }
    .task(id: specPropsKey([sections, activeItem, collapsed, width, collapsedWidth])) { if !specEq(vm.sections, sections) { vm.sections = sections }; if !specEq(vm.activeItem, activeItem) { vm.activeItem = activeItem }; if !specEq(vm.collapsed, collapsed) { vm.collapsed = collapsed }; if !specEq(vm.width, width) { vm.width = width }; if !specEq(vm.collapsedWidth, collapsedWidth) { vm.collapsedWidth = collapsedWidth } }
  }
}
