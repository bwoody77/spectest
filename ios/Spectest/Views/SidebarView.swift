import SwiftUI
import SpecRuntime

@Observable
final class SidebarViewModel {
  var activeItem: Any = ""
  var collapsed: Any = false
  var collapsedWidth: Any = "56px"
  var sections: Any? = nil
  var width: Any = "240px"
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
          if (specString(vm.collapsed) == specString(true)) {
            HStack(alignment: .center, ) {
              Text(specString("u00BB"))
                .font(.body.bold())
                .foregroundStyle(.secondary)
            }
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
            .frame(width: CGFloat(32))
            .frame(height: CGFloat(32))
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { /* event callback */ }
          }
        }
        .padding(CGFloat(8))
        HStack(alignment: .center, ) {
          if (specString(vm.collapsed) == specString(false)) {
            HStack(alignment: .center, ) {
              Text(specString("u00AB"))
                .font(.body.bold())
                .foregroundStyle(.secondary)
            }
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
            .frame(width: CGFloat(32))
            .frame(height: CGFloat(32))
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
            .onTapGesture { /* event callback */ }
          }
        }
        .padding(CGFloat(8))
        VStack(spacing: CGFloat(4)) {
          ForEach(Array((vm.sections as? [Any] ?? []).enumerated()), id: \.offset) { _idx, section in
            VStack() {
              if ((specString(vm.collapsed) == specString(false)) && (section as? [String: Any])?["title"] != nil) {
                Text(specString((section as? [String: Any])?["title"]))
                  .font(.body.bold())
                  .foregroundStyle(.tertiary)
              }
            }
            .padding(CGFloat(8))
            .opacity(specPx(((specString(vm.collapsed) == specString(false)) ? 1 : 0)))
            LazyVStack(spacing: CGFloat(8)) {
              ForEach(Array(((section as? [String: Any])?["items"] as? [Any] ?? []).enumerated()), id: \.offset) { _idx, item in
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  HStack(alignment: .center, ) {
                    Image(systemName: specIconName(specString(((item as? [String: Any])?["icon"] != nil ? (item as? [String: Any])?["icon"] : "circle"))))
                      .font(.system(size: specPx(18)))
                      .foregroundStyle(Color(hex: ((specString((item as? [String: Any])?["id"]) == specString(vm.activeItem)) ? "#1677ff" : "#496183") as? String ?? "#000"))
                  }
                  .frame(width: CGFloat(24))
                  .frame(height: CGFloat(24))
                  .frame(minWidth: CGFloat(24))
                  VStack() {
                    if (specString(vm.collapsed) == specString(false)) {
                      Text(specString((item as? [String: Any])?["label"]))
                        .font(.body.bold())
                        .foregroundStyle(Color(hex: ((specString((item as? [String: Any])?["id"]) == specString(vm.activeItem)) ? "#202732" : "#496183") as? String ?? "#000"))
                    }
                  }
                  .opacity(specPx(((specString(vm.collapsed) == specString(false)) ? 1 : 0)))
                }
                .padding(CGFloat(8))
                .background(Color(hex: ((specString((item as? [String: Any])?["id"]) == specString(vm.activeItem)) ? "#ffffff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
                .onTapGesture { /* event callback */ }
              }
            }
          }
        }
        .padding(CGFloat(8))
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
        .scrollIndicators(.visible)
      }
      .background(Color(.systemGroupedBackground))
      .frame(width: specPx(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)))
      .frame(height: CGFloat(0))
      .frame(minWidth: specPx(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)))
      .background(Color(.systemGroupedBackground))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.sections = sections; vm.activeItem = activeItem; vm.collapsed = collapsed; vm.width = width; vm.collapsedWidth = collapsedWidth }
  }
}
